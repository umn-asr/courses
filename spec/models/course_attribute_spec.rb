require "rails_helper"

RSpec.describe CourseAttribute do
  let(:course_attribute) { described_class.new }

  describe "type" do
    it "is 'attribute'" do
      expect(course_attribute.type).to eq("attribute")
    end
  end

  describe "valid?" do
    let(:valid_attributes) { {attribute_id: "PHYS", family: "CLE"} }

    it "is valid if the attribute_id is unique" do
      expect(described_class.new(valid_attributes).valid?).to be_truthy
    end

    it "is not valid if the attribute_id is not unique" do
      described_class.new(valid_attributes).save

      duplicate = described_class.new({attribute_id: valid_attributes[:attribute_id], family: "#{rand(3)}"})
      expect(duplicate.valid?).to be_falsey
    end

    it "is not valid if the attribute_id or family are blank" do
      [:attribute_id, :family].each do |required_attr|
        invalid_attributes = valid_attributes.dup
        invalid_attributes.delete(required_attr)
        expect(described_class.new(invalid_attributes).valid?).to be_falsey
      end
    end
  end
end
