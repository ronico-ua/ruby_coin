# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    remote_avatar_url { nil }
    role { :user }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    confirmed_at { Time.zone.now }

    trait :admin_user do
      role { :admin }
    end

    trait :with_avatar do
      remote_avatar_url { Faker::Avatar.image }
    end
  end
end
