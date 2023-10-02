# frozen_string_literal: true

module I18nExtended
  AVAILABLE_LOCALES = %w[uk en].freeze

  extend ActiveSupport::Concern

  included do
    around_action :switch_locale
  end

  private

  def switch_locale(&)
    locale = params.permit(:locale)[:locale]
    locale = I18n.default_locale unless AVAILABLE_LOCALES.include?(locale.to_s)
    I18n.with_locale(locale, &)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
