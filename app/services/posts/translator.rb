# frozen_string_literal: true

class Posts::Translator
  attr_accessor :post, :params

  def initialize(post, params)
    @post = post
    @params = params
  end

  def create_translation
    I18n.available_locales.each do |locale|
      next if I18n.locale == locale

      post.translations.create(
        title: params.dig('title_localizations', locale),
        description: params.dig('description_localizations', locale),
        locale:
      )
    end
  end

  def update_translation
    I18n.available_locales.each do |locale|
      next if I18n.locale == locale

      post.translations.find_by(locale:).update(
        title: params.dig('title_localizations', locale),
        description: params.dig('description_localizations', locale)
      )
    end
  end
end
