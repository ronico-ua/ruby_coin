# frozen_string_literal: true

class Posts::Translator
  attr_accessor :post, :params

  def initialize(post, params)
    @post = post
    @params = params
  end

  def call
    I18n.available_locales.each do |locale|
      article = post.translations.find_by(locale:)

      article.nil? ? create_post(locale) : update_post(article, locale)
    end
  end

  private

  def create_post(locale)
    post.translations.create(
      title: params.dig('title_localizations', locale),
      subtitle: params.dig('subtitle_localizations', locale),
      description: params.dig('description_localizations', locale),
      locale:
    )
  end

  def update_post(article, locale)
    if params.dig('title_localizations', locale).present?
      article.update(title: params.dig('title_localizations', locale))
    end

    if params.dig('subtitle_localizations', locale).present?
      article.update(subtitle: params.dig('subtitle_localizations', locale))
    end

    if params.dig('description_localizations', locale).present?  # rubocop:disable Style/GuardClause
      article.update(description: params.dig('description_localizations', locale))
    end
  end
end
