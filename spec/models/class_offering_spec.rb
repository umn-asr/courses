require "rails_helper"

RSpec.describe ClassOffering do
  it "has a type of Course" do
    expect(described_class.type).to eq("course")
  end

  describe "for_campus_and_term" do
    before(:each) do
      load "#{Rails.root}/db/seeds.rb"
    end

    it "returns only records with sections" do
      campus = Campus.fetch("UMNTC")
      term = Term.fetch("1149")
      class_offerings = ClassOffering.for_campus_and_term(campus, term)
      expect(class_offerings).not_to be_empty
      class_offerings.each do |offering|
        expect(offering.sections).not_to be_empty
      end
    end
  end
end
