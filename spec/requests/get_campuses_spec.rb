require "rails_helper"
require 'json'

RSpec.describe "get campuses" do
  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
  end

  describe "as json" do
    it "returns a structure that contains campus attributes" do
      get "/campuses"

      JSON.parse(response.body).each do |row|
        expect(row.keys).to include('type', 'abbreviation')
      end
    end
  end
end
