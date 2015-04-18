require "rails_helper"

RSpec.describe Instructor do
  let(:instructor) { described_class.new }

  describe "type" do
    it "is 'instructor'" do
      expect(instructor.type).to eq("instructor")
    end
  end
end
