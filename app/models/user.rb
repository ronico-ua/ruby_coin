# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  mount_uploader :avatar, PhotoUploader

  before_create :set_nickname

  has_many :posts, dependent: :delete_all

  validates :nickname, presence: true, uniqueness: { case_sensitive: false }, on: :update
  validates :email, presence: true
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }, if: -> { email.present? }

  enum :role, { admin: 0, moderator: 1, user: 2 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[nickname email id role unconfirmed_email created_at updated_at confirmed_at current_sign_in_at]
  end

  private

  def set_nickname
    self.nickname = email.split('@').first
    num = 2

    until User.find_by(nickname:).nil?
      self.nickname = "#{nickname}_#{num}"
      num += 1
    end
  end
end
