class FactoryScenariosController < ApplicationController
  
  def index
    @scenarios = Scenario.all
    render :layout => nil
  end
  
  def enact
    reset_session
    
    user_for_scenario = Scenario.find(params[:id]).enact(!!params[:clear])
    env["warden"].set_user user_for_scenario
    
    if method(:handle_factory_scenario)
      handle_factory_scenario
    else
      redirect_to "/"
    end
  end
end