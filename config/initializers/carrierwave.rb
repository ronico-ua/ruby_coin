# frozen_string_literal: true

CarrierWave.configure do |config|
  config.asset_host = ActionController::Base.asset_host
end
