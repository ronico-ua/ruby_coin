# frozen_string_literal: true

class Post < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :user
  mount_uploader :photo, PhotoUploader

  enum status: { active: 0, inactive: 1 }

  def truncated_description
    description.truncate(100, separator: /\s/)
  end
end
