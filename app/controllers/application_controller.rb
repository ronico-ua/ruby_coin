# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include I18nExtended
  include Pundit::Authorization
  include Pagy::Backend
  protect_from_forgery with: :exception
  prepend_before_action :set_i18n_locale_from_params

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_i18n_locale_from_params
    return if params[:locale].nil?

    I18n.locale = params[:locale]
  end

  def user_not_authorized(error_message = nil)
    flash[:alert] = error_message&.message || t('application_controller.alert')
    redirect_to(root_path)
  end
end
