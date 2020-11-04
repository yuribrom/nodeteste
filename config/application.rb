require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NodeTeste
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = "pt-BR"
    config.time_zone = 'Brasilia'
    config.i18n.fallbacks = true
    config.active_record.default_timezone = :local
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    #config.active_record.raise_in_transactional_callbacks = true
    ActiveRecord::SessionStore::Session.table_name = 'legacy_session_table'
    ActiveRecord::SessionStore::Session.primary_key = 'session_id'
    ActiveRecord::SessionStore::Session.data_column_name = 'data'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
