# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :title, presence: true

  scope :news, -> { order(created_at: :desc) }

  def self.ransackable_associations(_auth_object = nil)
    ['posts']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title created_at updated_at]
  end

  def self.policy_class
    if caller_locations(1..1).first.path.include?('management')
      Management::TagPolicy
    else
      TagPolicy
    end
  end
end
