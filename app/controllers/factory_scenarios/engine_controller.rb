module FactoryScenarios
  class EngineController < ApplicationController
    private

    def login_to_scenario(user_for_scenario=nil)
      reset_session

      return unless current_user
      sign_out(current_user)

      return unless user_for_scenario
      @current_user = user_for_scenario
      sign_in(:user, user_for_scenario)
    end

    def set_iframe_params
      @width = FactoryScenarios.config.iframe_width
    end
  end
end
