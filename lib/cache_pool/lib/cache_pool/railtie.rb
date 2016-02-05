module CachePool
  class Railtie < Rails::Railtie
    config.cache_pool = ActiveSupport::OrderedOptions.new

    config.before_initialize do
      require_relative File.join(Rails.root, "config", "initializers", "cache_pool")
    end
  end
end
