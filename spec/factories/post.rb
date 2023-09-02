# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    subtitle { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    photo do
      Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')))
    end
    status { 0 }
    main_post { false }
    user
  end
end
