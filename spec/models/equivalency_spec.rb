require "rails_helper"

RSpec.describe Equivalency do
  let(:subject_instance) { described_class.new }

  describe "#type" do
    it "is 'equivalency'" do
      expect(subject_instance.type).to eq('equivalency')
    end
  end

  describe "valid?" do
    let(:equivalency_id) { "00#{rand(100..999)}" }

    it "in not valid when there is no equivalency_id" do
      expect(subject_instance.valid?).to be_falsy
    end

    it "is valid if it has an equivalency_id" do
      subject_instance.equivalency_id = equivalency_id
      expect(subject_instance.valid?).to be_truthy
    end

    it "is not valid if the equivalency_id is not unique" do
      other = described_class.create(equivalency_id: equivalency_id)
      subject_instance.equivalency_id  = equivalency_id
      expect(subject_instance.valid?).to be_falsy
    end

    it "is valid when the equivalency_id is unique" do
      other = described_class.create(equivalency_id: equivalency_id)
      subject_instance.equivalency_id  = equivalency_id.next
      expect(subject_instance.valid?).to be_truthy
    end
  end
end