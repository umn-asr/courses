require 'rails_helper'

RSpec.describe CachePool do

  let(:index)       { Redis.new }
  let(:pool_size)   { 7 }

  subject { described_class.instance }

  describe "current" do
    it "returns the same cache when called multiple times" do
      expect(subject.current).to eq(subject.current)
    end

    it "has an expiration of 48 hours" do
      expect(subject.current.options[:expires_in]).to eq(48.hours)
    end

    context "when current_cache_db is not set in redis" do
      before do
        index.del('current_cache_db')
      end

      it "is the cache store for redis db 1" do
        expect(subject.current).to respond_to(:fetch)
        expect(subject.current.options[:db]).to eq(1)
      end
    end

    context "when the current_cache_db is set in redis" do
      let(:cache_number) { rand(1..pool_size) }

      before do
        index.set('current_cache_db', cache_number)
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
      expect(subject.current).to eq(subject.current)
    end

    it "is the cache store for the current db + 1" do
      current_db = subject.current.options[:db]
      expect(subject.next.options[:db]).to eq(current_db + 1)
    end

    context "when the current db is equal to the pool size" do
      before do
        index.set('current_cache_db', pool_size)
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