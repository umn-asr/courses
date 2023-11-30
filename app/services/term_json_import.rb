class TermJsonImport
  def initialize(json)
    self.json = json
  end

  def run
    Term.create(strm: json["term"]["strm"])
  end

  private

  attr_accessor :json
end
