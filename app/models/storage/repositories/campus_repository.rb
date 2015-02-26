require_relative 'repository'

module Storage
  module Repositories
    class CampusRepository
      include Repository

      def initialize(orm_adapter = ::Storage::Adapters::ActiveRecord, persistence_class = ::Storage::Models::ActiveRecord::Campus)
        super
      end

      private
      def map_record_out(record)
        Entities::CampusEntity.new.tap do |campus|
          campus.abbreviation = record.abbreviation
        end
      end
    end
  end
end
