require "helper"
class TestScenario < Test::Unit::TestCase
  context FactoryScenarios::Scenario do
    setup do 
      @path = FactoryScenarios.config.factory_scenarios_moneta_config[:path] = "./test/factory_scenarios.test.yml"
      @scenario = FactoryScenarios::Scenario.new(FactoryGirl.factories.first)
    end

    should "have a storage" do
      assert_equal Moneta::Adapters::YAML, @scenario.storage.class
    end

    context "Scenario.all" do
      should "return scenarios only for user factories" do
        assert_equal ["user", "user_child"], FactoryScenarios::Scenario.all.map(&:name)
      end
    end

    context "Scenario.find" do
      should "find a scenario by factory name" do
        assert_equal nil, FactoryScenarios::Scenario.find("not_user")
        assert_equal "user", FactoryScenarios::Scenario.find("user").name
      end
    end

    context "#enact" do
      context "when persisted? is true" do
        setup do
          @user = User.new
          User.meta_mock(:where, [@user])          
        end

        should "clear if do_clear is true" do
          @scenario.user_id = 20
          @scenario.enact(true)
          assert_equal 0, @scenario.user_id
        end

        should "not clear if do_clear isnt true" do
          @scenario.user_id = 20
          @scenario.enact
          assert_equal 20, @scenario.user_id
        end
      end

      should "create a new user if scenario isn't persisted and do_clear is true" do
        User.meta_mock(:where, [])
        assert_not_equal nil, @scenario.enact(true)
      end
    end

    context "#find_user" do
      should "return first found user" do
        found = User.new
        User.meta_mock(:where, [found])
        assert_equal found, @scenario.find_user
      end

      should "return nothing when no users found" do
        User.meta_mock(:where, [])
        assert_equal nil, @scenario.find_user
      end
    end

    should "not be persisted if User.where returns empty array" do
      User.meta_mock :where, []
      assert !@scenario.persisted?
    end

    should "be persisted if User.where returns a user" do
      User.meta_mock :where, [User.new]
      assert @scenario.persisted?
    end

    should "constantize the configured user class" do
      assert_equal User, @scenario.user_class
    end

    should "get its name from it's factory" do
      assert_equal "user", @scenario.name
    end

    context "#user_id" do
      should "get its user_id from storage" do
        @scenario.storage["user"] = 50
        assert_equal 50, @scenario.user_id
      end

      should "not have a user_id of 0 if storage doesn't have it" do
        @scenario.storage["user"] = 50
        @scenario.storage.delete "user"
        assert_equal 0, @scenario.user_id
      end
    end

    context "#clear" do
      should "clear the user_id for a the factory" do
        @scenario.storage["name"] = 500
        @scenario.clear
        assert_equal 0, @scenario.user_id
      end
    end
  end
end
