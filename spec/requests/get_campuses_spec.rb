require "rails_helper"
require 'json'

RSpec.describe "get campuses" do
  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
  end

  describe "as json" do
    it "returns a structure that contains campus attributes" do
      get "/campuses.json"

      element = JSON.parse(response.body)

      compare_element_to_documentation(element)
    end
  end

  describe "as xml" do
    it "returns a structure that is valid xml" do
      get "/campuses.xml"

      x = Nokogiri::XML(response.body)
      expect(x.errors).to be_empty
    end
  end
end
