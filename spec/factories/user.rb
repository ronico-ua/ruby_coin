# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    avatar { Faker::Avatar.image }
    role { 2 }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    confirmed_at { Time.zone.now }

    trait :admin_user do
      role { 0 }
    end
  end
end
