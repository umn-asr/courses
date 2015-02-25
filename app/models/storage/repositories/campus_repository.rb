require_relative 'repository'

module Storage
  module Repositories
    class CampusRepository
      include Repository

      def initialize(orm_adapter = ::Storage::Models::ActiveRecord::Campus)
        super
      end

      private
      def map_record_out(record)
        Entities::CampusEntity.new.tap do |campus|
          campus.abbreviation = record.abbreviation
        end
      end

      def map_record_in(entity)
        if exists?(entity.id)
          orm_adapter.find(entity.id).update_attributes(abbreviation: entity.abbreviation)
        else
          orm_adapter.new(abbreviation: entity.abbreviation).save
        end
      end
    end
  end
end
