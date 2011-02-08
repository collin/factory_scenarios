module FactoryScenarios
  module ::FactoryGirl
    def self.register_factory(factory, options = {})
      name = options[:as] || factory.name
      # write-over factories for this engine
      # if self.factories[name]
      #   raise DuplicateDefinitionError, "Factory already defined: #{name}"
      # end
      self.factories[name] = factory
    end
  end
  
  class Engine < Rails::Engine
    
    initializer "paths" do
      paths.factories Rails.root + "spec/factories"
      paths.datastore Rails.root + "db/factory_scenarios.#{Rails.env}.yml"

      config.moneta_backend = :YAML
      config.moneta_config = {
        :path => config.paths.datastore.first
      }      
    end

    config.to_prepare do
      # Doesn't seem to work :(
      # FactoryGirl.factories = {}
      
      root = Rails.application.config.root
      factories_path = FactoryScenarios::Engine.paths.factories.first
      globstring = (factories_path + "/**/*.rb").to_s

      
      Dir[globstring].each do |factory|
        load factory
      end
    end
  end
end