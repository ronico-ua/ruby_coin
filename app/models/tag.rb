# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :title, presence: true

  scope :news, -> { order(created_at: :desc) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[title created_at updated_at]
  end
end
