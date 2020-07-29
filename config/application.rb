require_relative 'boot'

require "rails"
require "active_record/railtie"
require "action_controller/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CourseGuide
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.autoload_paths += %W(#{Rails.root}/app/models/presenters #{Rails.root}/app/services #{Rails.root}/lib)
    config.caching = ActiveSupport::OrderedOptions.new
    config.x.caching.use = true
    config.log_level = :info
  end
end
