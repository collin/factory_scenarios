module FactoryScenarios
  class MailPreviewsController < EngineController
    def index
      set_iframe_params
      @previews = FactoryScenarios::Mail.previews
      render layout: false
    end

    def show
      preview = FactoryScenarios::Mail.previews[params[:mailer]][params[:name]]
      login_to_scenario preview.login_as
      @message = preview.mailer_message
      render layout: nil
    end
  end
end