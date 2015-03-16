require "rails_helper"
require 'json'

RSpec.describe "search courses", :focus do
  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
  end

  describe "by subject" do
    it "returns only courses that match the subject" do
      get "/campuses/UMNTC/terms/1149/courses.json?q=subject_id=AFRO"
      courses = JSON.parse(response.body)["courses"]

      expect(courses).not_to be_empty

      courses.each do |course|
        expect(course["subject"]["subject_id"]).to eq("AFRO")
      end
    end

    it "returns only courses that match either subject" do
      #You have to encode | as %7C or else Rspec will error
      get "/campuses/UMNTC/terms/1149/courses.json?q=subject_id=AFRO%7CPHYS"
      courses = JSON.parse(response.body)["courses"]

      expect(courses).not_to be_empty

      courses.each do |course|
        expect(course["subject"]["subject_id"]).to satisfy { |id| %w(AFRO PHYS).include?(id) }
      end
    end
  end

  describe "by catalog number" do
    it "returns only courses that match the catalog number" do
      get "/campuses/UMNTC/terms/1149/courses.json?q=catalog_number=1101W"
      courses = JSON.parse(response.body)["courses"]

      expect(courses).not_to be_empty

      courses.each do |course|
        expect(course["catalog_number"]).to eq("1101W")
      end
    end

    it "returns only courses that are greater than the catalog number" do
      get "/campuses/UMNTC/terms/1149/courses.json?q=catalog_number>3000"
      courses = JSON.parse(response.body)["courses"]

      expect(courses).not_to be_empty

      courses.each do |course|
        expect(course["catalog_number"]).to satisfy { |catalog_number| catalog_number.to_i > 3000 }
      end
    end

    it "returns only courses that are less than the catalog number" do
      get "/campuses/UMNTC/terms/1149/courses.json?q=catalog_number<3000"
      courses = JSON.parse(response.body)["courses"]

      expect(courses).not_to be_empty

      courses.each do |course|
        expect(course["catalog_number"]).to satisfy { |catalog_number| catalog_number.to_i < 3000 }
      end
    end

    it "returns only courses that are within the catalog_number range" do
      get "/campuses/UMNTC/terms/1149/courses.json?q=catalog_number>3000&catalog_number<4000"
      courses = JSON.parse(response.body)["courses"]

      expect(courses).not_to be_empty

      courses.each do |course|
        expect(course["catalog_number"]).to satisfy { |catalog_number| 3000 < catalog_number.to_i && catalog_number.to_i < 4000 }
      end
    end
  end

  describe "by cle attribute id" do
    it "returns only courses that match the cle attribute" do
      get "/campuses/UMNTC/terms/1149/courses.json?q=cle_attribute_id=WI"
      courses = JSON.parse(response.body)["courses"]

      expect(courses).not_to be_empty

      courses.each do |course|
        matching_attributes = course["cle_attributes"].select { |a| a["attribute_id"] == "WI" }
        expect(matching_attributes).not_to be_empty
      end
    end

    it "returns only courses that match the cle attribute" do
      get "/campuses/UMNTC/terms/1149/courses.json?q=cle_attribute_id=PHYS%7CHIS"
      courses = JSON.parse(response.body)["courses"]

      expect(courses).not_to be_empty

      courses.each do |course|
        matching_attributes = course["cle_attributes"].select { |a| %w(PHYS HIS).include?(a["attribute_id"]) }
        expect(matching_attributes).not_to be_empty
      end
    end
  end

  describe "by instruction mode id" do
    it "returns only courses that match the instruction mode" do
      get "/campuses/UMNTC/terms/1149/courses.json?q=instruction_mode_id=P"
      courses = JSON.parse(response.body)["courses"]

      expect(courses).not_to be_empty

      courses.each do |course|
        instruction_modes = course["sections"].collect { |s| s["instruction_mode"]["instruction_mode_id"] }
        expect(instruction_modes).to include("P")
      end
    end
  end

  describe "combining searches" do
    it "returns courses that match all criteria" do
      get "/campuses/UMNTC/terms/1149/courses.json?q=subject_id=AFRO&catalog_number>3000&catalog_number<4000&cle_attribute_id=GP&instruction_mode_id=P"
      courses = JSON.parse(response.body)["courses"]

      expect(courses).not_to be_empty

      course = courses.sample
      cle_attributes = course["cle_attributes"].collect { |a| a["attribute_id"] }
      instruction_modes = course["sections"].collect { |s| s["instruction_mode"]["instruction_mode_id"] }

      expect(course["subject"]["subject_id"]).to eq("AFRO")
      expect(course["catalog_number"].to_i).to be > 3000
      expect(course["catalog_number"].to_i).to be < 4000
      expect(cle_attributes).to include("GP")
      expect(instruction_modes).to include("P")
    end
  end
end
