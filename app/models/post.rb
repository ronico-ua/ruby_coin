# frozen_string_literal: true

class Post < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :user
  def truncated_description
    self.description.truncate(100, separator: /\s/)
  end
end
