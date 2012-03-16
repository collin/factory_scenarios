class MailPreviewsController < ApplicationController
  def index
    @previews = FactoryScenarios::Mail.previews
    render layout: false
  end

  def show
    preview = FactoryScenarios::Mail.previews[params[:mailer]][params[:name]]
    user = preview.login_as
    sign_out current_user if current_user
    sign_in user if user
    @message = preview.mailer_message
    render layout: nil
  end
end
