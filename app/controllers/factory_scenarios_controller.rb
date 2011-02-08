class FactoryScenariosController < ActionController::Base
  def index
    @scenarios = Scenario.all
  end
  
  def enact
    warden = env["warden"]
    clear = !!params[:clear]
    Scenario.find(params[:id]).enact(warden, clear)
    redirect_to root_path
  end
end