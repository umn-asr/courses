require "rails_helper"
require_relative "../../../app/models/entities/term"
require_relative "../../../app/models/repositories/term_repository"

RSpec.describe Entities::Term do
  let(:term_instance) { described_class.new }
  let(:repository_double) { instance_double(Repositories::TermRepository) }

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

  describe "id" do
    it "is the strm" do
      term_instance.strm = "1149"
      expect(term_instance.id).to eq("1149")
    end
  end

  describe "attributes" do
    it "contains the strm" do
      term_instance.strm = "1149"
      expect(term_instance.attributes.keys).to include(:strm)
      expect(term_instance.attributes[:strm]).to eq("1149")
    end
  end

  describe "valid?" do
    it "is valid if the repository says the strm is unique" do
      expect(repository_double).to receive(:unique?).with(strm: "1149").and_return(true)

      term_instance.strm = "1149"
      expect(term_instance.valid?(repository_double)).to be_truthy
    end

    it "is not valid if the repository says the abbrevation is not unique" do
      expect(repository_double).to receive(:unique?).with(strm: "1149").and_return(false)

      term_instance.strm = "1149"
      expect(term_instance.valid?(repository_double)).to be_falsey
    end

    it "is not valid if the strm is blank" do
      term_instance.strm = ""
      expect(term_instance.valid?(repository_double)).to be_falsey
    end
  end
end
