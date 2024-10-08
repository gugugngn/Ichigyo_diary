require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IchigyoDiary
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # 日本語化↓
    config.i18n.default_locale = :ja

    # 日本時間に設定↓
    config.time_zone = 'Asia/Tokyo'

    # ブラウザ画面左上の表示を削除↓
    unless Rails.env.production?
      config.middleware.delete(Rack::MiniProfiler)
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
