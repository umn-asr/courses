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

    def attributes
      {abbreviation: abbreviation}
    end
  end
end
