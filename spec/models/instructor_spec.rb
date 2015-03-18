require "rails_helper"

RSpec.describe Instructor do
  let(:instructor) { described_class.new }

  describe "type" do
    it "is 'instructor'" do
      expect(instructor.type).to eq("instructor")
    end
  end

  describe "name" do
    it "aliases the instructor_contact.name" do
      contact_double = instance_double(InstructorContact)
      rand_name = "#{rand}"
      expect(contact_double).to receive(:name).and_return(rand_name)

      allow(instructor).to receive(:instructor_contact).and_return(contact_double)
      expect(instructor.name).to eq(rand_name)
    end
  end

  describe "email" do
    it "aliases the instructor_contact.email" do
      contact_double = instance_double(InstructorContact)
      rand_email = "#{rand}"
      expect(contact_double).to receive(:email).and_return(rand_email)

      allow(instructor).to receive(:instructor_contact).and_return(contact_double)
      expect(instructor.email).to eq(rand_email)
    end
  end

  describe "role" do
    it "aliases the instructor_role.abbreviation" do
      role_double = instance_double(InstructorRole)
      rand_role = "#{rand}"
      expect(role_double).to receive(:abbreviation).and_return(rand_role)

      allow(instructor).to receive(:instructor_role).and_return(role_double)
      expect(instructor.role).to eq(rand_role)
    end
  end
end
