require 'helper'
class FactoryScenariosControllerTest < ActionController::TestCase
  tests FactoryScenarios::ScenariosController

  self.custom_routes = proc do
    mount FactoryScenarios::Engine => "/factory_scenarios", as: :factory_scenarios
  end

  def test_iframe_width_assignment
    User.meta_mock :where, []
    get(:index, :use_route => :factory_scenarios)
    assert_equal assigns(:width), "80%"
  end
  # context "#index" do
  #   should "assign iframe width" do
  #   end
  # end

  # context "#enact" do
    
  # end
end
