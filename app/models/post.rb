# frozen_string_literal: true

class Post < ApplicationRecord
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :tags
  # rubocop:enable Rails/HasAndBelongsToMany

  belongs_to :user
  def truncated_description
    description.truncate(100, separator: /\s/)
  end
end
