# frozen_string_literal: true

namespace :after_party do
  desc 'Deployment task: generate_photos'
  task generate_photos: :environment do
    Post.find_each do |post|
      post.photo.versions.each_key do |version|
        post.photo.recreate_versions!(version)
      end
    end
  end
end
