class CampusJsonImport
  def initialize(json)
    self.json = json
  end

  def run
    Campus.create(abbreviation: json["campus"]["abbreviation"])
  end

  private
  attr_accessor :json

end