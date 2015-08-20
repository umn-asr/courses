require "rails_helper"

RSpec.describe Enrollment do
  let(:enrollment) { described_class.new }

  describe "type" do
    it "is 'enrollment'" do
      expect(enrollment.type).to eq("enrollment")
    end
  end

  describe "fetch" do
    it "gets data from the enrollment service" do
      section = Section.new
      section.class_number = rand(1000)

      expect(EnrollmentService).to receive(:fetch).with(section.class_number).and_return(example_response(section.class_number))

      Enrollment.fetch(section)
    end

    it "returns an instantiated Enrollment" do
      section = Section.new
      section.class_number = rand(1000)

      source = example_response(section.class_number)[:enrollmentCapacity]

      expect(EnrollmentService).to receive(:fetch).with(section.class_number).and_return(example_response(section.class_number))

      enrollment = Enrollment.fetch(section)
      expect(enrollment).to be_a(Enrollment)
      expect(enrollment.enrollment_capacity).to eq(source[:enrollCapacity])
      expect(enrollment.waitlist_capacity).to eq(source[:waitCapacity])
      expect(enrollment.minimum_enrollment).to eq(source[:minEnrollment])
      expect(enrollment.enrollment_total).to eq(source[:enrollmentTotal])
      expect(enrollment.waitlist_total).to eq(source[:waitTotal])
    end
  end

  describe "instantiation" do
    it "is created with a hash of attributes" do
      section_class_number = rand(1000).to_s
      source = example_response(section_class_number)[:enrollmentCapacity]
      enrollment = Enrollment.new(source)
      expect(enrollment.enrollment_capacity).to eq(source[:enrollCapacity])
      expect(enrollment.waitlist_capacity).to eq(source[:waitCapacity])
      expect(enrollment.minimum_enrollment).to eq(source[:minEnrollment])
      expect(enrollment.enrollment_total).to eq(source[:enrollmentTotal])
      expect(enrollment.waitlist_total).to eq(source[:waitTotal])
    end
  end

  describe "to_h" do
    it "returns a hash of the expected format" do
      section_class_number = rand(1000).to_s
      source = example_response(section_class_number)[:enrollmentCapacity]
      enrollment = Enrollment.new(source)
      expect(enrollment.to_h[:type]).to eq("enrollment")
      expect(enrollment.to_h[:enrollment_capacity]).to eq(enrollment.enrollment_capacity)
      expect(enrollment.to_h[:waitlist_capacity]).to eq(enrollment.waitlist_capacity)
      expect(enrollment.to_h[:minimum_enrollment]).to eq(enrollment.minimum_enrollment)
      expect(enrollment.to_h[:enrollment_total]).to eq(enrollment.enrollment_total)
      expect(enrollment.to_h[:waitlist_total]).to eq(enrollment.waitlist_total)
      expect(enrollment.to_h[:reserve_capacities]).to eq([])
    end
  end
end

def example_response(section_class_number)
  [
    {
      type: "class",
      class_id: "#{section_class_number}",
      enrollmentCapacity: {
        "enrollmentSection": true,
        "enrollCapacity": 25,
        "waitCapacity": 5,
        "minEnrollment": 0,
        "enrollmentTotal": 8,
        "waitTotal": 0,
        "reserveCapacities": []
      }
    }
  ].first
end
