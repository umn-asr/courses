class EquivalencyJsonImport
  def initialize(json)
    self.json = json
  end

  def run
    equivalencies.each do |equivalency|
      Equivalency.create(equivalency_id: equivalency["equivalency_id"])
    end
  end

  private

  attr_accessor :json

  def equivalencies
    json["courses"].map { |course| course["equivalency"] }.flatten.compact
  end
end
