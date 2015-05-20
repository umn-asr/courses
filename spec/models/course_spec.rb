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
    let(:other_campus) { Campus.create(abbreviation: "UMNOTHER") }
    let(:other_term)   { Term.create(strm: "3359" ) }

    it "returns a collection" do
      expect(Course.for_campus_and_term(campus, term)).to respond_to(:each)
    end

    it "returns courses that match the supplied campus and term" do
      other_subject = Subject.create(subject_id: "TEST", description: "different campus term", campus_id: other_campus.id, term_id: other_term.id)
      other_course = other_subject.courses.create(course_id: rand(1000..9999).to_s)
      expect(Course.for_campus_and_term(campus, term)).to eq(courses)
      expect(Course.for_campus_and_term(campus, term)).to_not include(other_course)
    end

    it "returns an empty collection when there are no matches" do
      expect(Course.for_campus_and_term(other_campus, other_term)).to be_empty
    end

    it "does not return the course when the campus matches but the term does not" do
      expect(Course.for_campus_and_term(campus, other_term)).to be_empty
    end

    it "does not return the course when the term matches but the campus does not" do
      expect(Course.for_campus_and_term(other_campus, term)).to be_empty
    end

    it "returns courses in order of subject description", :focus do
      aab_subject = Subject.create(subject_id: "#{rand(100)}", description: "aab", campus_id: campus.id, term_id: term.id)
      aab_course = aab_subject.courses.create(course_id: rand(1000..9999).to_s)
      aaa_subject = Subject.create(subject_id: "#{rand(100)}", description: "aaa", campus_id: campus.id, term_id: term.id)
      aaa_course = aaa_subject.courses.create(course_id: rand(1000..9999).to_s)

      expect(Course.for_campus_and_term(campus, term).first).to eq(aaa_course)
      expect(Course.for_campus_and_term(campus, term).last).to eq(aab_course)
    end

    it "within a subject, courses are returned by catalog number", :focus do
      aaa_subject = Subject.create(subject_id: "#{rand(100)}", description: "aaa", campus_id: campus.id, term_id: term.id)
      course_last = aaa_subject.courses.create(course_id: rand(1000..9999).to_s, catalog_number: '1000W')
      course_first = aaa_subject.courses.create(course_id: rand(1000..9999).to_s, catalog_number: '1000')

      expect(Course.for_campus_and_term(campus, term).first).to eq(course_first)
      expect(Course.for_campus_and_term(campus, term).last).to eq(course_last)
    end
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
