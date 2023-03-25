# frozen_string_literal: true

class Tag < ApplicationRecord
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :posts
  # rubocop:enable Rails/HasAndBelongsToMany
end
