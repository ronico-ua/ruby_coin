# frozen_string_literal: true

FactoryBot.define do
  factory :ahoy_visit, class: 'Ahoy::Visit' do
    visitor_token { SecureRandom.uuid }
    ip { '127.0.0.1' }
    user_agent { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4)' }
  end
end
