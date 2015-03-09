require "rails_helper"
require 'json'

RSpec.describe "get terms" do
  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
  end

  describe "as json" do
    it "returns a structure that contains term attributes" do
      get "/terms"

      JSON.parse(response.body).each do |row|

        expect(row.keys).to include('term')

        row.keys.each do |key|
          expect(row[key]).to include('type', 'strm', 'id')
        end
      end
    end
  end
end
