# frozen_string_literal: true

module PostsHelper
  def title_value(post, locale)
    if action_name == 'create'
      params['post'].present? ? params.dig('post', 'title_localizations', locale) : ''
    elsif action_name == 'edit'
      post.translations.find_by(locale:)&.title
    else
      ''
    end
  end

  def description_value(post, locale)
    if action_name == 'create'
      params['post'].present? ? params.dig('post', 'description_localizations', locale) : ''
    elsif action_name == 'edit'
      post.translations.find_by(locale:)&.description
    else
      ''
    end
  end
end