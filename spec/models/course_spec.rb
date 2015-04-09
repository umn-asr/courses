require "rails_helper"

RSpec.describe Course do
  let(:course_instance) { described_class.new }

  describe ".for_campus_and_term" do
    let(:campus)  { Campus.create(abbreviation: "UMNTEST") }
    let(:term)    { Term.create(strm: "2259") }
    let(:subject) { Subject.create(subject_id: "TEST", description: "for testing", campus_id: campus.id, term_id: term.id) }
    let(:courses) {
                      3.times do
                        subject.courses.create(course_id: rand(1000..9999).to_s)
                      end

                      subject.courses
                  }

    it "returns courses that match the supplied campus and term" do
      expect(Course.for_campus_and_term(campus, term)).to eq(courses)
    end
    context "when there are no matches"

      it "returns an empty collection"
    context "when the campus matches but the term does not"
      it "does not return the course"
    context "when the term matches but the campus does not"
      it "does not return the course"

  end

  describe "type" do
    it "is 'course'" do
      expect(course_instance.type).to eq("course")
    end
  end

  describe "valid?" do
    it "is valid if the subject_id and course_id are unique" do
      expect(described_class.new(subject_id: rand(1..999_999), course_id: "002066").valid?).to be_truthy
    end

    it "is not valid if the combination of subject_id and course_id are not unique" do
      duplicate_subject_id = rand(1..999_999)
      described_class.new(subject_id: duplicate_subject_id, course_id: "002066").save

      duplicate = described_class.new(subject_id: duplicate_subject_id, course_id: "002066")
      expect(duplicate.valid?).to be_falsey
    end

    it "is not valid if the subject_id or course_id is blank" do
      expect(described_class.new(subject_id: "", course_id: "002066").valid?).to be_falsey
      expect(described_class.new(subject_id: rand(1..999_999), course_id: "").valid?).to be_falsey
    end
  end
end
