require_relative 'repository'

module Repositories
  class CampusRepository
    include Repository

    def initialize(persistence_class = ::Models::ActiveRecord::Campus)
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
