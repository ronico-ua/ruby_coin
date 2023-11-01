# frozen_string_literal: true

class Posts::Translator < BaseService
  attr_accessor :post, :params

  def initialize(post, params)
    @post = post
    @params = params
  end

  def call
    I18n.available_locales.each do |locale|
      article = post.post_translations.find_or_create_by(locale:)

      update_post(article, locale)
    end
  end

  private

  def update_post(article, locale)
    if params.dig('title_localizations', locale).present?
      article.update!(title: params.dig('title_localizations', locale))
    end

    if params.dig('subtitle_localizations', locale).present?
      article.update(subtitle: params.dig('subtitle_localizations', locale))
    end

    if params.dig('description_localizations', locale).present?  # rubocop:disable Style/GuardClause
      article.update(description: params.dig('description_localizations', locale))
    end
  end
end
