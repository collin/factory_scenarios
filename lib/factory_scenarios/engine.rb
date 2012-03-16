require "hashie/dash"
module FactoryScenarios
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
    @config ||= AppConfiguration.new(:user_class => 'User', :iframe_width => '80%')
  end

  class Engine < Rails::Engine
    isolate_namespace FactoryScenarios
    engine_name 'factory_scenarios'
    
    initializer "paths" do
      paths['factories'] = "#{Rails.root.to_s}/spec/factories"
      paths['factories'] << "#{Rails.root.to_s}/factories"
      paths['mail_previews'] = "#{Rails.root.to_s}/config/mail_preview.rb"
      paths['factory_scenario_datastore'] = "#{Rails.root.to_s}/db/factory_scenarios.#{Rails.env}.yml"

      config.factory_scenarios_moneta_backend = :YAML unless config.respond_to? :factory_scenarios_moneta_backend
      config.factory_scenarios_moneta_config = {
        :path => config.paths['factory_scenario_datastore'].first
      } unless config.respond_to? :factory_scenarios_moneta_config
    end

    initializer "factory_scenarios.config", :before => :load_config_initializers do |app|
      config
    end

    config.to_prepare do
      root = Rails.application.config.root

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