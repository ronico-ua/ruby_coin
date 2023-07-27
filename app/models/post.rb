# frozen_string_literal: true

class Post < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :user
  mount_uploader :photo, PhotoUploader

  enum status: { active: 0, inactive: 1 }

  def truncated_description
    description.truncate(100, separator: /\s/)
  end

  def similar_posts(post)
    post_tags = post.tags.pluck(:id)
    Post.joins(:tags).where(tags: { id: post_tags }).where.not(id: post.id).distinct.limit(3)
  end
end
