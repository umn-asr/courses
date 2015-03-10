require "rails_helper"

RSpec.describe Campus do
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

  describe "valid?" do
    it "is valid if the abbrevation is unique" do
      expect(described_class.new(abbreviation: "UMNRO").valid?).to be_truthy
    end

    it "is not valid if the abbrevation is not unique" do
      described_class.new(abbreviation: "UMNRO").save

      duplicate = described_class.new(abbreviation: "UMNRO")
      expect(duplicate.valid?).to be_falsey
    end

    it "is not valid if the abbreviation is blank" do
      expect(described_class.new(abbreviation: "").valid?).to be_falsey
    end
  end
end
