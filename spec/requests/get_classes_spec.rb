require "rails_helper"
require 'json'

RSpec.describe "get classes" do
  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
  end

  describe "as json" do
    it "returns a structure that matches our reference structure " do
      get "/campuses/UMNTC/terms/1149/classes.json"
      element = JSON.parse(response.body)
      expect(element.keys).to include("courses", "term", "campus")

      element.each do |_, v|
        compare_element_to_documentation(v)
      end
    end

    it "only returns records with sections" do
      get "/campuses/UMNTC/terms/1149/classes.json"
      element = JSON.parse(response.body)
      element["courses"].each do |course|
        expect(course["sections"]).not_to be_empty
      end
    end
  end

  describe "with invalid campus" do
    it "returns a 404" do
      get "/campuses/uwmadison/terms/1149/courses.json"
      expect(response.status).to eq(404)
    end
  end

  describe "with invalid term" do
    it "returns a 404" do
      get "/campuses/UMNTC/terms/9999/courses.json"
      expect(response.status).to eq(404)
    end
  end
end
