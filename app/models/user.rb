# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :nickname

  has_many :posts

  enum :role, { admin: 0, moderator: 1, user: 2}

  private

  def nickname
    self.nickname = Faker::Internet.username(specifier: 10, separators: ['_'])
  end
end
