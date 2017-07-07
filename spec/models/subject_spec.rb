require "rails_helper"

RSpec.describe Subject do
  let(:subject_instance) { described_class.new }

  describe "type" do
    it "is 'subject'" do
      expect(subject_instance.type).to eq ("subject")
    end
  end

  describe "valid?" do
    let(:valid_attributes) { {subject_id: "PHYS", description: "Physics", campus_id: rand(1..500), term_id: rand(1..500)}}

    it "is valid if the subject_id is unique for a campus and term" do
      base_subject = described_class.new(valid_attributes)
      expect(base_subject.valid?).to be_truthy
    end

    it "is not valid if the subject_id is not unique for a campus and term" do
      Campus.create( { id: valid_attributes[:campus_id], abbreviation: "UMNTC" } )
      Term.create( { id: valid_attributes[:term_id], strm: "1179" } )

      described_class.new(valid_attributes).save

      duplicate = described_class.new({subject_id: valid_attributes[:subject_id], description: "#{rand(3)}", campus_id: valid_attributes[:campus_id], term_id: valid_attributes[:term_id]})
      expect(duplicate.valid?).to be_falsey

      described_class.delete_all
      Campus.delete_all
      Term.delete_all
    end

    it "is not valid if the subject_id, description, campus_id, or term_id are blank" do
      [:subject_id, :description, :campus_id, :term_id].each do |required_attr|
        invalid_attributes = valid_attributes.dup
        invalid_attributes.delete(required_attr)
        expect(described_class.new(invalid_attributes).valid?).to be_falsey
      end
    end
  end
end
