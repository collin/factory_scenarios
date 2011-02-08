module FactoryScenarios
  require "moneta/adapters/#{FactoryScenarios::Engine.config.moneta_backend.to_s.downcase}"
  storage_class = Moneta::Adapters.const_get(FactoryScenarios::Engine.config.moneta_backend)
  Storage = storage_class.new FactoryScenarios::Engine.config.moneta_config
end