module Entities
  class Campus
    include ActiveModel::Model

    attr_accessor :abbreviation
    validates_presence_of :abbreviation

    def type
      "campus"
    end

    def id
      abbreviation
    end

    def valid?(repository)
      super &&
      repository.unique?(abbreviation: abbreviation)
    end

    def attributes
      {abbreviation: abbreviation}
    end
  end
end
