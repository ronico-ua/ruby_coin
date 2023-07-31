# frozen_string_literal: true

class Post < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :user
  mount_uploader :photo, PhotoUploader
  before_save :deactivate_previous_main_post, if: :main_post?

  enum status: { active: 0, inactive: 1 }

  def truncated_description
    description.truncate(100, separator: /\s/)
  end

  private

  def deactivate_previous_main_post
    previous_main_post = Post.find_by(main_post: true)
    previous_main_post.update(main_post: false) if previous_main_post.present? && previous_main_post != self
  end
end
