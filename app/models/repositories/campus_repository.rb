module Repositories
  class CampusRepository
    include ::Hexagram::Repositories::Repository

    def initialize(persistence_class = ::Persisters::ActiveRecord::Campus, orm_adapter = nil)
      orm_adapter ||= persistence_class.orm_adapter
      super(persistence_class, orm_adapter)
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
