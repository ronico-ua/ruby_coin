# frozen_string_literal: true

CarrierWave.configure do |config|
  config.asset_host = ActionController::Base.asset_host
  if Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
  end
end
