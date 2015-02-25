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
        if valid?(entity)
          map_record_in(entity)
        end
      end

      def update(entity)
        if valid?(entity)
          map_record_in(entity)
        end
      end

      def exists?(id)
        orm_adapter.exists?(id)
      end

      def valid?(entity)
        entity.valid?(self)
      end

      def where(options)
        orm_adapter.where(options)
      end

      private

      attr_accessor :orm_adapter
    end
  end
end
