require "rails"
require "factory_girl"
require "haml"
require "warden"
require "moneta"

Factory = FactoryGirl unless defined?(Factory)

module FactoryScenarios
  require "factory_scenarios/engine"
  autoload :Mail, "factory_scenarios/mail"

  def self.storage
    require "moneta/adapters/#{FactoryScenarios.config.factory_scenarios_moneta_backend.to_s.downcase}"
    storage_class = Moneta::Adapters.const_get(FactoryScenarios.config.factory_scenarios_moneta_backend)
    storage_class.new FactoryScenarios.config.factory_scenarios_moneta_config
  end

end