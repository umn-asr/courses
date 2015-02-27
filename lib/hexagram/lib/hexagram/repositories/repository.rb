module Hexagram
  module Repositories
    module Repository
      def initialize(persistence_class, orm_adapter)
        self.persistence_class = persistence_class
        @class = persistence_class.name.match(/\w+$/)[0]
        self.orm_adapter = orm_adapter
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

      def exists?(entity)
        orm_adapter.exists?(entity, persistence_class)
      end

      def valid?(entity)
        entity.valid?(self)
      end

      def where(options)
        orm_adapter.where(options, persistence_class)
      end

      def unique?(attributes_to_check)
        attributes_to_check.all? { |k, v| where({k => v}).empty? }
      end

      private

      attr_accessor :orm_adapter, :persistence_class

      def map_record_out(record)
        eval("Entities::#{@class}").new.tap do |entity|
          entity.attributes.keys.each do |attr|
            entity.public_send("#{attr}=".to_sym, record.public_send(attr))
          end
        end
      end
    end
  end
end
