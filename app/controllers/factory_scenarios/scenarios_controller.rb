module FactoryScenarios
  class ScenariosController < EngineController

    def index
      set_iframe_params
      @scenarios = Scenario.all
      render :layout => nil
    end

    def enact
      user_for_scenario = Scenario.find(params[:id]).enact(!!params[:clear])

      login_to_scenario user_for_scenario

      if respond_to?(:handle_factory_scenario)
        handle_factory_scenario
      else
        redirect_to "/"
      end
    end
  end
end