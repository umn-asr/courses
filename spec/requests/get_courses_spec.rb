require "rails_helper"
require 'json'
require_relative "../../lib/course_contract_tests/lib/reference_test"

RSpec.describe "get courses" do
  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
  end

  describe "as json" do
    it "returns a structure that matches our reference structure " do
      get "/campuses/UMNTC/terms/1159/courses.json"

      parsed_response = JSON.parse(response.body)
      expect { ReferenceTest.test_structure(parsed_response) }.not_to raise_error
    end
  end
end
