module Storage
  module Entities
    class CampusEntity
      include ActiveModel::Model
      attr_accessor :abbreviation
      #validates_uniqueness_of :abbreviation
      #
      def type
        "campus"
      end

      def id
        abbreviation
      end
    end
  end
end
