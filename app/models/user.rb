# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  before_create :set_nickname

  has_many :posts, dependent: :delete_all

  enum :role, { admin: 0, moderator: 1, user: 2 }

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
