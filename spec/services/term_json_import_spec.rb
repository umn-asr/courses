require "rails_helper"
require "json"

RSpec.describe TermJsonImport do
  let (:course_json) { JSON.parse(File.read('test/fixtures/courses_example.json')) }
  subject { described_class.new(course_json) }

  describe "run" do
    it "builds a Term with the supplied strm" do
      Term.delete_all

      subject.run
      expect(Term.find_by(strm: course_json["term"]["strm"])).to_not be_nil
    end

    it "is ok if the term exists" do
      Term.create(strm: course_json["term"]["strm"])
      subject.run

      expect(Term.find_by(strm: course_json["term"]["strm"])).to_not be_nil
    end
  end
end