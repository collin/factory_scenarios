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
    config.to_prepare do
      root = Rails.application.config.root
      globstring = (root+"spec/factories/**/*.rb").to_s
      Dir[globstring].each do |factory|
        load factory
      end
    end
  end
end