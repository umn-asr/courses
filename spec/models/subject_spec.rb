require "rails_helper"

RSpec.describe Subject do
  let(:subject_instance) { described_class.new }

  describe "type" do
    it "is 'subject'" do
      expect(subject_instance.type).to eq ("subject")
    end
  end

  describe "valid?" do
    let(:valid_attributes) { {subject_id: "PHYS", description: "Physics"}}

    it "is valid if the subject_id is unique" do
      expect(described_class.new(valid_attributes).valid?).to be_truthy
    end

    it "is not valid if the subject_id is not unique" do
      described_class.new(valid_attributes).save

      duplicate = described_class.new({subject_id: valid_attributes[:subject_id], description: "#{rand(3)}"})
      expect(duplicate.valid?).to be_falsey
    end

    it "is not valid if the subject_id or description are blank" do
      [:subject_id, :description].each do |required_attr|
        invalid_attributes = valid_attributes.dup
        invalid_attributes.delete(required_attr)
        expect(described_class.new(invalid_attributes).valid?).to be_falsey
      end
    end
  end
end
