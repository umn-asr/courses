if Rails.configuration.caching.use
  Rails.configuration.action_dispatch.rack_cache        = true
  Rails.configuration.action_controller.perform_caching = true
  Rails.configuration.caching.default_expiry            = 48.hours
  Rails.cache                                           = CachePool.instance.current
  FastCache                                             = MemoryCache.instance
  Rails.cache.options[:expires_in]                      = Rails.configuration.caching.default_expiry
  FastCache.options[:expires_in]                        = Rails.configuration.caching.default_expiry
else
  Rails.configuration.action_dispatch.rack_cache        = false
  Rails.configuration.action_controller.perform_caching = false
  Rails.cache                                           = ActiveSupport::Cache::NullStore.new
  FastCache                                             = ActiveSupport::Cache::NullStore.new
end
