require 'helper'
require 'pathname'
require 'fileutils'
require 'moneta/adapters/yaml'

# Mocks
def Object.meta_mock(method, _return)
  (class << self; self end).send(:define_method, method) {|*args| _return }
end

require "./../factory_scenarios/app/models/factory_scenarios/scenario"
require "factory_girl"
require "active_record"
class ::User
end
FactoryGirl.define do
  factory :user do
  end
end

class TestFactoryScenarios < Test::Unit::TestCase
  DEFAULT_FILE_PATH = "/db/factory_scenarios.development.yml"
  context "storage" do
    teardown do
      FactoryScenarios.config.factory_scenarios_moneta_config[:path] = DEFAULT_FILE_PATH      
    end

    should "has default configuration" do
      assert_equal "User", FactoryScenarios.config.user_class
      assert_equal "80%", FactoryScenarios.config.iframe_width
      assert_equal :YAML, FactoryScenarios.config.factory_scenarios_moneta_backend
      assert_equal DEFAULT_FILE_PATH, FactoryScenarios.config.factory_scenarios_moneta_config[:path]
    end

    should "create the default storage" do
      temp = Tempfile.new("factory_scenarios").path + ".yml"
      FactoryScenarios.config.factory_scenarios_moneta_config[:path] = temp
      assert_equal Moneta::Adapters::YAML, FactoryScenarios.storage.class
    end

  end

  context FactoryScenarios::Scenario do
    setup do 
      @path = FactoryScenarios.config.factory_scenarios_moneta_config[:path] = "./test/factory_scenarios.test.yml"
      @scenario = FactoryScenarios::Scenario.new(FactoryGirl.factories.first)
    end

    should "have a storage" do
      assert_equal Moneta::Adapters::YAML, @scenario.storage.class
    end

    context "#find_user" do
      should "return first found user" do
        found = User.new
        User.meta_mock(:where, [found])
        assert_equal found, @scenario.find_user
      end

      should "return nothing when no users found" do
        User.meta_mock(:where, [])
        assert_equal nil, @scenario.find_user
      end
    end

    should "not be persisted if User.where returns empty array" do
      User.meta_mock :where, []
      assert !@scenario.persisted?
    end

    should "be persisted if User.where returns a user" do
      User.meta_mock :where, [User.new]
      assert @scenario.persisted?
    end

    should "constantize the configured user class" do
      assert_equal User, @scenario.user_class
    end

    should "get its name from it's factory" do
      assert_equal "user", @scenario.name
    end

    context "#user_id" do
      should "get its user_id from storage" do
        @scenario.storage["user"] = 50
        assert_equal 50, @scenario.user_id
      end

      should "not have a user_id of 0 if storage doesn't have it" do
        @scenario.storage["user"] = 50
        @scenario.storage.delete "user"
        assert_equal 0, @scenario.user_id
      end
    end

    context "#clear" do
      should "clear the user_id for a the factory" do
        @scenario.storage["name"] = 500
        @scenario.clear
        assert_equal 0, @scenario.user_id
      end
    end
  end
end
