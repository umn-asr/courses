require "rails_helper"
require "json"
require_relative "../../lib/course_contract_tests/lib/reference_test"

RSpec.describe "create course" do
  let (:course_data) { JSON.parse(File.read('test/fixtures/courses_example.json')) }

  before(:each) do
    Term.delete_all
    Campus.delete_all
  end

  describe "when passed valid syntax" do
    it "should receive an ok response" do
      post "/campuses/UMNTC/terms/1149/courses", course: course_data
      expect(response).to have_http_status(200)
    end
  end

  describe "when passed invalid syntax" do
    it "should return a bad response" do
      course_data.delete("campus")
      post "/campuses/UMNTC/terms/1149/courses", course: course_data
      expect(response).to have_http_status(400)
    end
  end
end
