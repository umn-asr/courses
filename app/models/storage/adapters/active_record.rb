module Storage
  module Adapters
    module ActiveRecord
      def self.find(id, persistence_class)
        persistence_class.find(id)
      end

      def self.each(persistence_class)
      end

      def self.build(persistence_class)
        persistence_class.new
      end

      def self.exists?(id, persistence_class)
        persistence_class.exists?(id)
      end

      def self.where(options, persistence_class)
        persistence_class.where(options)
      end

      def self.save(entity, persistence_class)
        if exists?(entity.id, persistence_class)
          persistence_class.find(entity.id).update_attributes(entity.attributes)
        else
          persistence_class.create(entity.attributes)
        end
      end
    end
  end
end
