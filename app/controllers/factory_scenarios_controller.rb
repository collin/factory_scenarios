class FactoryScenariosController < ActionController::Base
  def index
    @scenarios = Scenario.all
  end
  
  def enact
    warden = env["warden"]
    Scenario.find(params[:id]).enact(warden)
    redirect_to root_path
  end
end