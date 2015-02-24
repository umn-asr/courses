require "rails_helper"
require "json"
require_relative "../../lib/reference_test"

RSpec.describe "create course" do
  describe "when passed valid syntax" do
    it "should receive an ok response" do
      post "/campuses/UMNTC/terms/1149/courses", course: ReferenceTest.reference_structure
      expect(response).to have_http_status(200)
    end
  end

  describe "when passed invalid syntax" do
    it "should return a bad response" do
      munged_reference_structure = ReferenceTest.reference_structure
      munged_reference_structure.delete(munged_reference_structure.keys.sample)
      post "/campuses/UMNTC/terms/1149/courses", course: munged_reference_structure
      expect(response).to have_http_status(400)
    end
  end
end
