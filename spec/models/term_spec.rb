require "rails_helper"

RSpec.describe Term do
  let(:term_instance) { described_class.new }

  describe "type" do
    it "is 'term'" do
      expect(term_instance.type).to eq("term")
    end
  end

  describe "strm" do
    it "can be set" do
      term_instance.strm = "1149"
      expect(term_instance.strm).to eq("1149")
    end

    it "can be set at instantiation" do
      expect(described_class.new(strm: "1149").strm).to eq("1149")
    end
  end

  describe "valid?" do
    it "is valid if the abbrevation is unique" do
      expect(described_class.new(strm: "1149").valid?).to be_truthy
    end

    it "is not valid if the abbrevation is not unique" do
      described_class.new(strm: "1149").save

      duplicate = described_class.new(strm: "1149")
      expect(duplicate.valid?).to be_falsey
    end

    it "is not valid if the strm is blank" do
      expect(described_class.new(strm: "").valid?).to be_falsey
    end
  end
end
