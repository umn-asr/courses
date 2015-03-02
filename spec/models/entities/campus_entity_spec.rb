require "rails_helper"
require_relative "../../../app/models/entities/campus"
require_relative "../../../app/models/repositories/campus_repository"

RSpec.describe Entities::Campus do
  let(:campus_instance) { described_class.new }

  describe "type" do
    it "is 'campus'" do
      expect(campus_instance.type).to eq("campus")
    end
  end

  describe "abbreviation" do
    it "can be set" do
      campus_instance.abbreviation = "UMNTC"
      expect(campus_instance.abbreviation).to eq("UMNTC")
    end

    it "can be set at instantiation" do
      expect(described_class.new(abbreviation: "UMNRO").abbreviation).to eq("UMNRO")
    end
  end

  describe "id" do
    it "is the abbreviation" do
      campus_instance.abbreviation = "UMNTC"
      expect(campus_instance.id).to eq("UMNTC")
    end
  end

  describe "attributes" do
    it "contains the abbreviation" do
      campus_instance.abbreviation = "UMNTC"
      expect(campus_instance.attributes.keys).to include(:abbreviation)
      expect(campus_instance.attributes[:abbreviation]).to eq("UMNTC")
    end
  end

  describe "valid?" do
    it "is valid if the repository says the abbrevation is unique" do
      repository_double = instance_double(Repositories::CampusRepository)
      expect(repository_double).to receive(:unique?).with(abbreviation: "UMNTC").and_return(true)

      campus_instance.abbreviation = "UMNTC"
      expect(campus_instance.valid?(repository_double)).to be_truthy
    end
    it "is not valid if the repository says the abbrevation is not unique" do
      repository_double = instance_double(Repositories::CampusRepository)
      expect(repository_double).to receive(:unique?).with(abbreviation: "UMNTC").and_return(false)

      campus_instance.abbreviation = "UMNTC"
      expect(campus_instance.valid?(repository_double)).to be_falsey
    end
  end
end
