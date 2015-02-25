module Storage
  module Entities
    class CampusEntity
      include ActiveModel::Model

      attr_accessor :abbreviation

      def type
        "campus"
      end

      def id
        abbreviation
      end

      def valid?(repository)
        repository.where(abbreviation: abbreviation).empty?
      end
    end
  end
end
