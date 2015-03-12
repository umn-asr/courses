require "rails_helper"
require 'json'

RSpec.describe "get courses" do
  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
  end

  describe "as json" do
    it "returns a structure that matches our reference structure " do
      get "/campuses/UMNTC/terms/1159/courses.json"
      element = JSON.parse(response.body)
      expect(element.keys).to include("courses", "term", "campus")

      element.each do |_, v|
        compare_element_to_documentation(v)
      end

    end
  end
end
