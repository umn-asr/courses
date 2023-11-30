require "rails_helper"
require "json"

RSpec.describe CampusJsonImport do
  let(:course_json) { JSON.parse(File.read("test/fixtures/courses_example.json")) }
  subject { described_class.new(course_json) }

  describe "run" do
    it "builds a Campus with the supplied abbreviation" do
      Campus.delete_all

      subject.run
      expect(Campus.find_by(abbreviation: course_json["campus"]["abbreviation"])).to_not be_nil
    end

    it "is ok if the campus exists" do
      Campus.create(abbreviation: course_json["campus"]["abbreviation"])
      subject.run

      expect(Campus.find_by(abbreviation: course_json["campus"]["abbreviation"])).to_not be_nil
    end
  end
end
