# frozen_string_literal: true

module PostsHelper
  def current_data(post, item, locale)
    if action_name == 'create'
      params['post'].present? ? params.dig('post', "#{item}_localizations", locale) : ''

    elsif action_name == 'edit'
      post.translations.find_by(locale:)&.send(item)

    else
      ''

    end
  end
end
