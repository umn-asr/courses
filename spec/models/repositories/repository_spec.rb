require "rails_helper"
require_relative "../../../app/models/repositories/campus_repository"

RSpec.describe CampusRepository do
  let(:orm_adapter) { Hexagram::Adapters::ActiveRecord }

  describe "build" do
    it "returns an empty instance of a CampusEntity" do
      persistence_class = OpenStruct

      campus_repository = described_class.new(persistence_class, orm_adapter)

      ret = campus_repository.build
      expect(ret).to be_a(Entities::CampusEntity)
      expect(ret.abbreviation).to be_nil
    end
  end

  describe "find" do
    it "returns an empty instance of a CampusEntity" do
      persistence_class = Persisters::ActiveRecord::Campus
      persistence_instance = OpenStruct.new
      persistence_instance.abbreviation = "UMNTC"

      allow(persistence_class).to receive(:find).with("UMNTC").and_return(persistence_instance)

      campus_repository = described_class.new(persistence_class, orm_adapter)

      ret = campus_repository.find("UMNTC")
      expect(ret).to be_a(Entities::CampusEntity)
      expect(ret.abbreviation).to eq("UMNTC")
    end
  end
end
