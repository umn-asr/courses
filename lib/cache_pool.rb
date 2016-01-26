class CachePool
  include Singleton

  def initialize
    self.pool_size            = 4
    self.redis_configuration  = {}
    build_pool
  end

  def current
    pool[current_index]
  end

  def next
    pool[next_index]
  end

  def next!
    index.set('current_cache_db', next_db)
  end

  private
  attr_accessor :pool_size, :redis_configuration

  def pool
    @pool ||= []
  end

  def build_pool
    1.upto(pool_size).each do |i|
      pool << ActiveSupport::Cache.lookup_store(:redis_store, redis_configuration.merge(db: i))
    end
  end

  def index
    @index ||= Redis.new(redis_configuration.merge(db: 0))
  end

  def current_db
    if index.get('current_cache_db')
      index.get('current_cache_db').to_i
    else
      1
    end
  end

  def next_db
    (current_db % pool_size) + 1
  end

  def current_index
    index_for(current_db)
  end

  def next_index
    index_for(next_db)
  end

  def index_for(db)
    db - 1
  end
end
