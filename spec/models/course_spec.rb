require "rails_helper"

RSpec.describe Course do
  let(:course_instance) { described_class.new }

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
