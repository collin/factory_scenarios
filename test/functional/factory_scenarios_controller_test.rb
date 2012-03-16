require 'helper'
class FactoryScenariosControllerTest < ActionController::TestCase
  tests FactoryScenarios::ScenariosController

  self.custom_routes = proc do
    mount FactoryScenarios::Engine => "/factory_scenarios", as: :factory_scenarios
  end

  context "#index" do
    should "set the iframe width" do
      User.meta_mock :where, []
      get(:index, :use_route => :factory_scenarios)
      assert_equal "80%", assigns(:width)
    end
  end
  
  context "#enact" do

    class FactoryScenarios::ScenariosController
      def current_user
        @current_user
      end

      def sign_in(scope, user)
        @current_user = user
      end

      def sign_out(user)
        @current_user = null
      end
    end

    setup do
      @path = FactoryScenarios.config.factory_scenarios_moneta_config[:path] = "./test/factory_scenarios.test.yml"
      @scenario = FactoryScenarios::Scenario.new(FactoryGirl.factories.first)
    end

    should "login as user for scenario" do
      user = User.new
      User.meta_mock :where, [user]
      get(:enact, :id => "user", :use_route => :factory_scenarios)
      assert_equal user, assigns(:current_user)   
    end

    should "not clear current scenario if clear parm isnt 1" do
      @scenario.user_id = 30
      user = User.new
      User.meta_mock :where, [user]
      get(:enact, :id => "user", :use_route => :factory_scenarios)
      assert_equal  30, @scenario.user_id      
    end

    should "clear current scenario if clear param is 1" do
      @scenario.user_id = 30
      user = User.new
      User.meta_mock :where, [user]
      get(:enact, :id => "user", :clear => "1", :use_route => :factory_scenarios)
      assert_not_equal  30, @scenario.user_id
    end

    should "redirect to /" do
      user = User.new
      User.meta_mock :where, [user]
      get(:enact, :id => "user", :use_route => :factory_scenarios)
      assert_redirected_to "/"      
    end

    should "call handle_factory_scenario instead of redirecting to / if it is defined" do
      class FactoryScenarios::ScenariosController
        def handle_factory_scenario
          redirect_to "/other"
        end
      end

      user = User.new
      User.meta_mock :where, [user]
      get(:enact, :id => "user", :use_route => :factory_scenarios)
      assert_redirected_to "/other"      
      
      FactoryScenarios::ScenariosController.send(:remove_method, :handle_factory_scenario)
    end
  end
end
