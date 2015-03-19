require "rails_helper"

RSpec.describe InstructionMode do
  let(:instruction_mode) { described_class.new }

  describe "type" do
    it "is 'instruction_mode'" do
      expect(instruction_mode.type).to eq("instruction_mode")
    end
  end

  describe "valid?" do
    let(:valid_attributes) { {instruction_mode_id: "P"} }

    it "is valid if the instruction_mode_id is unique" do
      expect(described_class.new(valid_attributes).valid?).to be_truthy
    end

    it "is not valid if the instruction_mode_id is not unique" do
      described_class.new(valid_attributes).save

      duplicate = described_class.new(instruction_mode_id: "P")
      expect(duplicate.valid?).to be_falsey
    end

    it "is not valid if the instruction_mode_id is missing" do
      invalid_attributes = valid_attributes.dup
      invalid_attributes.delete(:instruction_mode_id)
      expect(described_class.new(invalid_attributes).valid?).to be_falsey
    end
  end
end
