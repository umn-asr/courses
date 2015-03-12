require "rails_helper"
require "json"
require_relative "../../lib/course_contract_tests/lib/reference_test"

RSpec.describe "create course" do
  before(:each) do
    Term.delete_all
    Campus.delete_all
    Course.delete_all
  end

  describe "when passed valid syntax" do
    it "should receive an ok response" do
      post "/campuses/UMNTC/terms/1149/courses", course: ReferenceTest.reference_structure
      expect(response).to have_http_status(200)
    end
  end

  describe "when passed invalid syntax" do
    it "should return a bad response" do
      munged_reference_structure = ReferenceTest.reference_structure
      munged_reference_structure.delete("campus")
      post "/campuses/UMNTC/terms/1149/courses", course: munged_reference_structure
      expect(response).to have_http_status(400)
    end
  end
end
