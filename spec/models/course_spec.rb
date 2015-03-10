require "rails_helper"

RSpec.describe Course do
  let(:course_instance) { described_class.new }

  describe "type" do
    it "is 'course'" do
      expect(course_instance.type).to eq("course")
    end
  end

  describe "valid?" do
    before(:each) do
      load "#{Rails.root}/db/seeds.rb"
    end

    it "is valid if the campus_id, term_id, and course_id are unique" do
      expect(described_class.new(campus_id: "UMNRC", term_id: "1159", course_id: "002066").valid?).to be_truthy
    end

    it "is not valid if the combination of campus_id, term_id, and course_id are not unique" do
      described_class.new(campus_id: "UMNRC", term_id: "1159", course_id: "002066").save

      duplicate = described_class.new(campus_id: "UMNRC", term_id: "1159", course_id: "002066")
      expect(duplicate.valid?).to be_falsey
    end

    it "is not valid if the campus_id, term_id, or course_id are blank" do
      expect(described_class.new(campus_id: "", term_id: "", course_id: "").valid?).to be_falsey
    end
  end
end
