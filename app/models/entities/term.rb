module Entities
  class Term
    include ActiveModel::Model

    attr_accessor :strm
    validates_presence_of :strm

    def type
      "term"
    end

    def id
      strm
    end

    def valid?(repository)
      super &&
      repository.unique?(strm: strm)
    end

    def attributes
      {strm: strm}
    end
  end
end

