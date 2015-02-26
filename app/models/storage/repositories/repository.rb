module Storage
  module Repositories
    module Repository
      def initialize(persistence_class, orm_adapter = persistence_class.orm_adapter)
        self.orm_adapter = orm_adapter
        self.persistence_class = persistence_class
      end

      def find(id)
        map_record_out(orm_adapter.find(id, persistence_class))
      end

      def build
        map_record_out(orm_adapter.build(persistence_class))
      end

      def save(entity)
        if valid?(entity)
          orm_adapter.save(entity, persistence_class)
        end
      end

      def update(entity)
        if valid?(entity)
          orm_adapter.save(entity, persistence_class)
        end
      end

      def exists?(id)
        orm_adapter.exists?(id, persistence_class)
      end

      def valid?(entity)
        entity.valid?(self)
      end

      def where(options)
        orm_adapter.where(options, persistence_class)
      end

      private

      attr_accessor :orm_adapter, :persistence_class
    end
  end
end
