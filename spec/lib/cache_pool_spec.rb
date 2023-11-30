require "rails_helper"

RSpec.describe CachePool::CachePool do
  describe "configuration" do
    let(:random_pool_size) { rand(100..999) }
    let(:random_redis_configuration) { {url: "redis://some_#{rand(999)}_url"} }

    before do
      Rails.configuration.cache_pool.pool_size = random_pool_size
      Rails.configuration.cache_pool.redis_configuration = random_redis_configuration
      Singleton.__init__(CachePool::CachePool)  # undocumented method to reload our CachePool Singleton see http://stackoverflow.com/questions/1909181/how-to-test-a-singleton-class
    end

    it "gets pool size from Rails configuration" do
      expect(described_class.instance.send(:pool_size)).to eq(random_pool_size)
    end

    it "gets pool size from Rails configuration" do
      expect(described_class.instance.send(:redis_configuration)).to eq(random_redis_configuration)
    end
  end

  describe "behavior" do
    let(:redis_container_configuration) { {url: "redis://redis:6379"} }
    let(:pool_size) { rand(3..9) }
    let(:index) { Redis.new(redis_container_configuration) }

    subject { described_class.instance }

    before do
      Rails.configuration.cache_pool.pool_size = pool_size
      Rails.configuration.cache_pool.redis_configuration = redis_container_configuration
      Singleton.__init__(CachePool::CachePool) # undocumented method to reload our CachePool Singleton see http://stackoverflow.com/questions/1909181/how-to-test-a-singleton-class
    end

    describe "current" do
      it "returns the same cache when called multiple times" do
        expect(subject.current).to eq(subject.current)
      end

      it "has an expiration of 48 hours" do
        expect(subject.current.options[:expires_in]).to eq(Rails.configuration.caching.default_expiry)
      end

      context "when current_cache_db is not set in redis" do
        before do
          index.del("current_cache_db")
        end

        it "is the cache store for redis db 1" do
          expect(subject.current).to respond_to(:fetch)
          expect(subject.current.options[:db]).to eq(1)
        end
      end

      context "when the current_cache_db is set in redis" do
        let(:cache_number) { rand(1..pool_size) }

        before do
          index.set("current_cache_db", cache_number)
        end

        after do
          index.flushdb
        end

        it "is cache store for the current_cache_db" do
          expect(subject.current.options[:db]).to eq(cache_number)
        end
      end
    end

    describe "next" do
      it "returns the same cache when called multiple times" do
        expect(subject.next).to eq(subject.next)
      end

      it "is the cache store for the current db + 1" do
        current_db = subject.current.options[:db]
        expect(subject.next.options[:db]).to eq(current_db + 1)
      end

      context "when the current db is equal to the pool size" do
        before do
          index.set("current_cache_db", pool_size)
        end

        after do
          index.del("current_cache_db")
        end

        it "is the cache store for redis db 1" do
          expect(subject.next.options[:db]).to eq(1)
        end
      end
    end

    describe "next!" do
      it "makes the next store the current store" do
        old_next = subject.next
        subject.next!
        expect(subject.current).to eq(old_next)
      end
    end
  end
end
