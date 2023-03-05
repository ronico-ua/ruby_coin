require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ronico
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.exceptions_app = routes

    config.i18n.available_locales = %i[en uk]
    config.i18n.default_locale = :uk
    config.time_zone = 'Kyiv'
    # config.active_record.default_timezone = :local
    config.active_job.queue_adapter = :sidekiq
  end
end
