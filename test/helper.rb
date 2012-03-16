require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'
require 'rails'
require 'rails/test_help'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'factory_scenarios'

# Mocks
def Object.meta_mock(method, _return)
  (class << self; self end).send(:define_method, method) {|*args| _return }
end

require "factory_girl"
require "active_record"

class ::User
  def save!; true end
  def id
    @id ||= rand(10000).to_i
  end
end

class ::NotUser; end

FactoryGirl.define do
  factory :user do; end
  factory :not_user do; end
  factory :user_child, :parent => :user do; end
end


# Like with_routing except:
#
#   * Can be used across an entire TestCase
#   * Can work with a real browser (i.e. Capybara) in integration tests.
#   * Routes are appended to already defined routes
#
# Just assign a block to the class attribute "custom_routes". This block will
# execute as if it is being called from within the routes.rb draw block.
module TestRoutes
  extend ActiveSupport::Concern

  included do
    class_attribute :custom_routes
    setup :install_routes
    teardown :restore_routes
  end

  private

  def install_routes
    # Easier to refer to
    routes = Rails.application.routes

    # Clear out any already loaded routes
    routes.disable_clear_and_finalize = true
    routes.clear!

    # Load routes from application and engines
    Rails.application.routes_reloader.paths.each{ |path| load(path) }

    # Bring custom route block into closure and eval in context of draw
    if custom = self.class.custom_routes
      puts "mounting routes :D"
      routes.draw {instance_eval &custom}
    end

    routes.routes.each do |route|
      puts route.inspect
    end
  ensure
    # Wrap up route defination
    routes.disable_clear_and_finalize = false
    routes.finalize!
  end

  def restore_routes
    # Go back to just whatever the app and engines say
    Rails.application.reload_routes!
  end

end

class ActionController::TestCase
  include TestRoutes
end