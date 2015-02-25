require_relative 'query_object'

module Storage
  module QueryObjects
    class FindCampus
      include QueryObject

      def initialize(repository = Repositories::CampusRepository.new)
        super
      end

      def call
        repository.load_all
      end
    end
  end
end
