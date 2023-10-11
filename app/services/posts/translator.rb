# frozen_string_literal: true

class Posts::Translator < BaseService
  attr_accessor :post, :params

  def initialize(post, params)
    @post = post
    @params = params
  end

  def call
    I18n.available_locales.each do |locale|
      translation = post.translations.find_by(locale:)

      if translation.present?
        translation.update(
          title: current_locale_params.dig('title', locale),
          description: current_locale_params.dig('description', locale)
        )
      else
        post.translations.create(
          title: current_locale_params.dig('title', locale),
          description: current_locale_params.dig('description', locale),
          locale:
        )
      end
    end
  end

  private

  def current_locale_params
    current_params = {}

    params.each do |key, value|
      current_params[key] = value if value.is_a?(ActionController::Parameters)
    end

    current_params
  end
end
