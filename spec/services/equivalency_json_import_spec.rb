require "rails_helper"

RSpec.describe EquivalencyJsonImport do
  let (:course_json) { JSON.parse(File.read('test/fixtures/courses_example.json')) }
  subject { described_class.new(course_json) }

  describe "run" do
    let(:equivalencies)     { course_json["courses"].map { |course| course["equivalency"] }.flatten }

    it "builds Equivalencies for the supplied equivalency" do
      Equivalency.delete_all
      subject.run
      expect(Equivalency.all.count).to be > 0
      equivalencies.compact.each do |equivalency|
        expect(Equivalency.find_by(equivalency_id: equivalency["equivalency_id"])).to_not be_nil
      end
    end

    it "is ok if the attribute exists" do
      Equivalency.create(equivalency_id: equivalencies.compact.first["equivalency_id"])
      subject.run
      equivalencies.compact.each do |equivalency|
        expect(Equivalency.find_by(equivalency_id: equivalency["equivalency_id"])).to_not be_nil
      end
    end

    it "is ok if a course has no equivalencies" do
      expect(equivalencies).to include(nil)
      subject.run
      equivalencies.compact.each do |equivalency|
        expect(Equivalency.find_by(equivalency_id: equivalency["equivalency_id"])).to_not be_nil
      end
    end
  end
end