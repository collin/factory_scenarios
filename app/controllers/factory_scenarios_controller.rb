class FactoryScenariosController < ApplicationController
  
  def index
    @scenarios = Scenario.all
    render :layout => nil
  end
  
  def enact
    sign_out(current_user)
    @current_user = nil # otherwise the session gets serialized with the
                        #   user we just signed out of. may be a bug w/warden/devise
                        
    @current_user = user_for_scenario = Scenario.find(params[:id]).enact(!!params[:clear])
    sign_in(user_for_scenario, :bypass => true)

    if defined?(handle_factory_scenario) == "method"
      handle_factory_scenario
    else
      redirect_to "/"
    end
  end
end