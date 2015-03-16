require "rails_helper"

RSpec.describe Section do
  let(:section) { described_class.new }

  describe "type" do
    it "is 'section'" do
      expect(section.type).to eq("section")
    end
  end

  describe "valid?" do
    let(:valid_attributes) { {course_id: rand(3), class_number: "#{rand(3)}", number: "#{rand(3)}", component: "LEC" } }

    it "is valid with the correct attributes" do
      expect(described_class.new(valid_attributes).valid?).to be_truthy
    end

    it "is not valid if the attribute_id or family are blank" do
      valid_attributes.keys.each do |required_attr|
        invalid_attributes = valid_attributes.dup
        invalid_attributes.delete(required_attr)
        expect(described_class.new(invalid_attributes).valid?).to be_falsey
      end
    end
  end
end
