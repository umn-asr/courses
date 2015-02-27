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
        campus.attributes.keys.each do |attr|
          campus.public_send("#{attr}=".to_sym, record.public_send(attr))
        end
      end
    end
  end
end
