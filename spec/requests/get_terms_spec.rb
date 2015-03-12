require "rails_helper"
require 'json'

RSpec.describe "get terms" do
  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
  end

  describe "as json" do
    it "returns a structure that contains term attributes" do
      get "/terms"

      compare_element_to_documentation(JSON.parse(response.body))
    end
  end
end
