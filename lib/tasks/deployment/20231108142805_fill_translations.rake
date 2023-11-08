# frozen_string_literal: true

namespace :after_party do
  desc 'Deployment task: fill_translations'

  task fill_translations: :environment do
    Post.find_each do |post|
      I18n.available_locales.each do |locale|
        translation = post.post_translations.find_or_create_by(locale:)

        translation.update(title: post.title) if translation.title.nil?
        translation.update(subtitle: post.subtitle) if translation.subtitle.nil?
        translation.update(description: post.description) if translation.description.nil?
      end
    end
  end
end
