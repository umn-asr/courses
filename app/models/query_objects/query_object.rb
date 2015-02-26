module QueryObjects
  module QueryObject
    def initialize(repository)
      @repository = repository
    end

    private
    attr_reader :repository
  end
end
