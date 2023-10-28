# frozen_string_literal: true

module PostsHelper
  def current_data(post, item, locale)
    if action_name == 'create'
      params['post'].present? ? params.dig('post', "#{item}_localizations", locale) : ''
    else
      post.post_translations.find_by(locale:)&.send(item)
    end
  end
end
