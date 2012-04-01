require 'helper'
require 'pathname'
require 'fileutils'
require 'moneta/adapters/yaml'

class TestFactoryScenarios < Test::Unit::TestCase
  DEFAULT_FILE_PATH = "/db/factory_scenarios.development.yml"
  context "storage" do
    teardown do
      FactoryScenarios.config.factory_scenarios_moneta_config[:path] = DEFAULT_FILE_PATH      
    end

    should "has default configuration" do
      assert_equal "User", FactoryScenarios.config.user_class
      assert_equal "80%", FactoryScenarios.config.iframe_width
      assert_equal true, FactoryScenarios.config.open_in_iframe
      assert_equal :YAML, FactoryScenarios.config.factory_scenarios_moneta_backend
      assert_equal DEFAULT_FILE_PATH, FactoryScenarios.config.factory_scenarios_moneta_config[:path]
    end

    should "create the default storage" do
      temp = Tempfile.new("factory_scenarios").path + ".yml"
      FactoryScenarios.config.factory_scenarios_moneta_config[:path] = temp
      assert_equal Moneta::Adapters::YAML, FactoryScenarios.storage.class
    end

  end
end