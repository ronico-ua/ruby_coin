# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('application_controller.alert')
    redirect_to(request.referer || root_path)
  end
end
