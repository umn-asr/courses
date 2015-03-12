require "rails_helper"
require 'json'

RSpec.describe "get campuses" do
  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
  end

  describe "as json" do
    it "returns a structure that contains campus attributes" do
      get "/campuses"

      element = JSON.parse(response.body)

      compare_element_to_documentation(element)
    end
  end
end

