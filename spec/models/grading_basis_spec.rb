require "rails_helper"

RSpec.describe GradingBasis do
  let(:grading_basis) { described_class.new }

  describe "type" do
    it "is 'grading_basis'" do
      expect(grading_basis.type).to eq("grading_basis")
    end
  end

  describe "valid?" do
    let(:valid_attributes) { {grading_basis_id: "OPT"} }

    it "is valid if the grading_basis_id is unique" do
      expect(described_class.new(valid_attributes).valid?).to be_truthy
    end

    it "is not valid if the grading_basis_id is not unique" do
      described_class.new(valid_attributes).save

      duplicate = described_class.new(grading_basis_id: "OPT")
      expect(duplicate.valid?).to be_falsey
    end

    it "is not valid if the grading_basis_id is missing" do
      invalid_attributes = valid_attributes.dup
      invalid_attributes.delete(:grading_basis_id)
      expect(described_class.new(invalid_attributes).valid?).to be_falsey
    end
  end
end
