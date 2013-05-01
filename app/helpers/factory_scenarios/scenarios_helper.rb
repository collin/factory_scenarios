module FactoryScenarios
  module ScenariosHelper

    def scenario_link(scenario)
      link_to "Login", enact_scenario_path(scenario),
              :id => "enact_#{scenario.name}",
              'data-open-in-iframe' => FactoryScenarios.config.open_in_iframe
    end

    def reload_scenario_link(scenario)
      link_to "Reset data & Login", enact_scenario_path(scenario, :clear => true),
              :class => :reload, :id => "reload_#{scenario.name}",
              'data-open-in-iframe' => FactoryScenarios.config.open_in_iframe
    end

  end
end