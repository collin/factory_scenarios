class FactoryScenarios::EnvironmentController < FactoryScenarios::EngineController
  def integration
    render layout: nil
  end
end