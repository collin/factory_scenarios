require "factory_girl"
require "haml"
require "warden"
require "moneta"

module FactoryScenarios
  require "factory_scenarios/engine"
  autoload :Storage, "factory_scenarios/storage"
  autoload :Mail, "factory_scenarios/mail"
end