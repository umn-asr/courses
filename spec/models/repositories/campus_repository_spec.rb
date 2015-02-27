require "rails_helper"
require_relative "../../../app/models/repositories/campus_repository"

RSpec.describe Repositories::CampusRepository do
  let(:persistence_class) { Object.new }
  let(:orm_adapter) { Adapters::ActiveRecord }
  let(:campus_repository) { described_class.new(persistence_class, orm_adapter) }
  let(:entity) { instance_double(Entities::CampusEntity) }

  describe "save" do
    describe "when the entity is valid" do
      it "saves it through the orm_adapter" do
        allow(entity).to receive(:valid?).with(campus_repository).and_return(true)
        expect(orm_adapter).to receive(:save).with(entity, persistence_class)
        campus_repository.save(entity)
      end
    end

    describe "when the entity is not valid" do
      it "does not save it through the orm_adapter" do
        allow(entity).to receive(:valid?).with(campus_repository).and_return(false)
        expect(orm_adapter).not_to receive(:save).with(entity, persistence_class)
        campus_repository.save(entity)
      end
    end
  end

  describe "update" do
    describe "when the entity is valid" do
      it "saves it through the orm_adapter" do
        allow(entity).to receive(:valid?).with(campus_repository).and_return(true)
        expect(orm_adapter).to receive(:save).with(entity, persistence_class)
        campus_repository.update(entity)
      end
    end

    describe "when the entity is not valid" do
      it "does not save it through the orm_adapter" do
        allow(entity).to receive(:valid?).with(campus_repository).and_return(false)
        expect(orm_adapter).not_to receive(:save).with(entity, persistence_class)
        campus_repository.update(entity)
      end
    end
  end

  describe "exists?" do
    it "asks the orm_adapter if the entity exists" do
      random_return = [true, false].sample
      expect(orm_adapter).to receive(:exists?).with(entity, persistence_class).and_return(random_return)
      expect(campus_repository.exists?(entity)).to eq(random_return)
    end
  end

  describe "valid?" do
    it "asks the entity if it is valid" do
      random_return = [true, false].sample
      expect(entity).to receive(:valid?).with(campus_repository).and_return(random_return)
      expect(campus_repository.valid?(entity)).to eq(random_return)
    end
  end

  describe "where" do
    it "asks te orm_adapter" do
      options = {foo: "bar"}
      returned = Object.new
      expect(orm_adapter).to receive(:where).with(options, persistence_class).and_return(returned)

      expect(campus_repository.where(options)).to eq(returned)
    end
  end

  describe "unique" do
    let(:attributes) { {abbreviation: "UMNTC"} }

    describe "when a entity with that attribute value has already been persisted" do
      it "returns false" do
        expect(orm_adapter).to receive(:where).with(attributes, persistence_class).and_return([Object.new])
        expect(campus_repository.unique?(attributes)).to be_falsey
      end
    end

    describe "when a entity with that attribute value has not been persisted" do
      it "returns true" do
        expect(orm_adapter).to receive(:where).with(attributes, persistence_class).and_return([])
        expect(campus_repository.unique?(attributes)).to be_truthy
      end
    end
  end

  describe "build" do
    it "returns an empty instance of a CampusEntity" do
      orm_adapter = Adapters::ActiveRecord
      persistence_class = OpenStruct

      campus_repository = described_class.new(persistence_class, orm_adapter)

      ret = campus_repository.build
      expect(ret).to be_a(Entities::CampusEntity)
      expect(ret.abbreviation).to be_nil
    end
  end

  describe "find" do
    it "returns an empty instance of a CampusEntity" do
      orm_adapter = Adapters::ActiveRecord
      persistence_class = Models::ActiveRecord::Campus
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
