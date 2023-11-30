require "rails_helper"

RSpec.describe CourseAttributeJsonImport do
  let(:course_json) { JSON.parse(File.read("test/fixtures/courses_example.json")) }
  subject { described_class.new(course_json) }

  describe "run" do
    let(:course_attributes) { course_json["courses"].map { |course| course["course_attributes"] }.flatten }

    it "builds CourseAttributes for the supplied abbreviation" do
      CourseAttribute.delete_all
      subject.run

      expect(CourseAttribute.all.count).to be > 0
      course_attributes.compact.each do |attribute_hash|
        expect(CourseAttribute.find_by(attribute_id: attribute_hash["attribute_id"], family: attribute_hash["family"])).to_not be_nil
      end
    end

    it "is ok if the attribute already exists" do
      CourseAttribute.create(attribute_id: course_attributes.first["attribute_id"], family: course_attributes.first["family"])
      subject.run
      course_attributes.compact.each do |attribute_hash|
        expect(CourseAttribute.find_by(attribute_id: attribute_hash["attribute_id"], family: attribute_hash["family"])).to_not be_nil
      end
    end

    it "is ok if a course has no attributes" do
      course_json["courses"].first.delete("course_attributes")
      expect(course_attributes).to include(nil)
      subject.run
      course_attributes.compact.each do |attribute_hash|
        expect(CourseAttribute.find_by(attribute_id: attribute_hash["attribute_id"], family: attribute_hash["family"])).to_not be_nil
      end
    end
  end
end
