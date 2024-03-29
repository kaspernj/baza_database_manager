require File.expand_path("boot", __dir__)

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BazaDatabaseManager; end

class BazaDatabaseManager::Application < Rails::Application
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  config.load_defaults 7.0

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
  # config.time_zone = 'Central Time (US & Canada)'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.yml").to_s]
  config.i18n.default_locale = :en
  config.i18n.available_locales = [:da, :en]

  # Autoload lib/ folder including all subdirectories
  config.autoload_paths += Dir["#{config.root}/lib/**/"]
end
