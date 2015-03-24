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

    it "is valid if the attribute_id and family are unique" do
      expect(described_class.new(valid_attributes).valid?).to be_truthy
    end

    it "is valid if the attribute_id is not unique but the family is" do
      described_class.new(valid_attributes).save

      new_instance = described_class.new({attribute_id: valid_attributes[:attribute_id], family: "#{rand(3)}"})
      expect(new_instance.valid?).to be_truthy
    end

    it "is valid if the attribute_id is unique but the family is not" do
      described_class.new(valid_attributes).save

      new_instance = described_class.new({attribute_id: "#{rand(3)}", family: valid_attributes[:family]})
      expect(new_instance.valid?).to be_truthy
    end

    it "is not valid if the attribute_id and family are both duplicates" do
      described_class.new(valid_attributes).save

      new_instance = described_class.new(valid_attributes)
      expect(new_instance.valid?).to be_falsey
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
