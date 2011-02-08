module FactoryScenarios
  require "moneta/adapters/#{FactoryScenarios::Engine.config.factory_scenarios_moneta_backend.to_s.downcase}"
  storage_class = Moneta::Adapters.const_get(FactoryScenarios::Engine.config.factory_scenarios_moneta_backend)
  Storage = storage_class.new FactoryScenarios::Engine.config.factory_scenarios_moneta_config
end