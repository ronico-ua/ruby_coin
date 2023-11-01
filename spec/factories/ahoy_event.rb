# frozen_string_literal: true

FactoryBot.define do
  factory :ahoy_event, class: 'Ahoy::Event' do
    name { 'Viewed Post' }
    time { Time.zone.now }
    visit { association(:ahoy_visit) }
  end
end
