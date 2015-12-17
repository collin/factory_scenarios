require "hashie/dash"
module FactoryScenarios
  class AppConfiguration < Hashie::Dash
    property :iframe_width
    property :user_class
    property :factory_scenarios_moneta_backend
    property :factory_scenarios_moneta_config
    property :open_in_iframe
  end

  module ::FactoryGirl
    def self.register_factory(factory, options = {})
      self.factories.class.class_eval {
        def add_forced(item)
          @items[item.name.to_sym] = item
        end
      }

      self.factories.add_forced(factory)
    end

    def self.register_sequence(sequence, options = {})
      self.sequences.class.class_eval {
        def add_forced(item)
          @items[item.name.to_sym] = item
        end
      }

      self.sequences.add_forced(sequence)
    end
  end

  def self.config
    @config ||= AppConfiguration.new(
      :user_class => 'User',
      :iframe_width => '80%',
      :open_in_iframe => true,
      :factory_scenarios_moneta_backend => :YAML,
      :factory_scenarios_moneta_config => {
        :path => "#{Rails.root.to_s}/db/factory_scenarios.#{Rails.env}.yml"
      }
    )
  end

  class Engine < Rails::Engine
    isolate_namespace FactoryScenarios
    engine_name 'factory_scenarios'

    initializer "paths" do
      paths['factories'] = "#{Rails.root.to_s}/spec/factories"
      paths['factories'] << "#{Rails.root.to_s}/factories"
      paths['mail_previews'] = "#{Rails.root.to_s}/config/mail_preview.rb"
    end

    initializer "factory_scenarios.config", :before => :load_config_initializers do |app|
      config
    end

    config.to_prepare do
      root = Rails.application.config.root

      if ActiveRecord::Base.connected?
        for factories_path in FactoryScenarios::Engine.paths['factories']
          globstring = (factories_path + "/**/*.rb").to_s

          Dir[globstring].each do |factory|
            load factory
          end
        end

        preview_paths = FactoryScenarios::Engine.paths['mail_previews'].first
        Dir[preview_paths].each do |previews|
          load previews
        end
      end
    end
  end
end
