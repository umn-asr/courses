module Repositories
  class CampusRepository
    include Hexagram::Repositories::Repository

    def initialize(persistence_class = ::Persisters::ActiveRecord::Campus, orm_adapter = nil)
      orm_adapter ||= persistence_class.orm_adapter
      super(persistence_class, orm_adapter)
    end
  end
end
