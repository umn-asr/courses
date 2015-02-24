require "rails_helper"
require 'json'

RSpec.describe "create course" do
  describe "when passed valid syntax" do
    it "should receive an ok response" do
      post "/campuses/UMNTC/terms/1149/courses", course: reference_structure
      expect(response).to have_http_status(200)
    end
  end

  describe "when passed invalid syntax" do
    it "should return a bad response" do
      munged_reference_structure = reference_structure
      munged_reference_structure.delete(munged_reference_structure.keys.sample)
      post "/campuses/UMNTC/terms/1149/courses", course: munged_reference_structure
      expect(response).to have_http_status(400)
    end
  end

  def test_structure(actual, reference)
    if actual.respond_to?(:keys) || reference.respond_to?(:keys)
      expect { actual.keys }.not_to raise_error, failure_message(actual, reference)
      expect { reference.keys }.not_to raise_error, failure_message(actual, reference)

      expect(actual.keys).to eq(reference.keys), failure_message(actual, reference)

      actual.keys.each do |k|
        test_structure(actual[k], reference[k])
      end
    elsif actual.respond_to?(:each) || actual.respond_to?(:each)
      expect { actual.each }.not_to raise_error, failure_message(actual, reference)
      expect { reference.each }.not_to raise_error, failure_message(actual, reference)

      test_structure(actual.sample, reference.sample)
    else
      #noop
    end
  end

  def failure_message(actual, reference)
    "Actual: #{actual.inspect}, Reference: #{reference.inspect}"
  end
end

def reference_structure
  {
    "campus" => {
      "type" => "campus",
      "id" => "UMNTC",
      "abbreviation" => "UMNTC"
    },
    "term" => {
      "type" => "term",
      "id" => "1149",
      "strm" => "1149"
    },
    "courses" => [
      {
        "type" => "course",
        "id" => 1,
        "catalog_number" => "12345"
      },
    ]
  }
end
