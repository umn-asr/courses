if Rails.configuration.caching.use
  Rails.configuration.action_dispatch.rack_cache = true
  Rails.configuration.action_controller.perform_caching = true
  Rails.cache = CachePool.instance.current
  FastCache = MemoryCache.instance
else
  Rails.configuration.action_dispatch.rack_cache = false
  Rails.configuration.action_controller.perform_caching = false
  Rails.cache = ActiveSupport::Cache::NullStore.new
  FastCache = ActiveSupport::Cache::NullStore.new
end
