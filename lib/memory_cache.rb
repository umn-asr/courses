class MemoryCache
  include Singleton

  def initialize
    @memory_store = ActiveSupport::Cache::MemoryStore.new(size: 1.gigabyte)
  end

  def method_missing(m, *args, &block)
    @memory_store.send(m, *args, &block)
  end
end
