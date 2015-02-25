module Storage
  module Repositories
    module Repository
      def initialize(orm_adapter)
        self.orm_adapter = orm_adapter
      end

      def find(id)
        map_record_out(orm_adapter.find(id))
      end

      def find_all
        orm_adapter.find_each.lazy.map &method(:map_record_out)
      end

      def create
        map_record_out(orm_adapter.new)
      end

      def save(entity)
        map_record_in(entity)
      end

      def update(entity)
        map_record_in(entity)
      end

      def exists?(id)
        orm_adapter.exists?(id)
      end

      private
      attr_accessor :orm_adapter
    end
  end
end
