require "rails_helper"
require_relative "../../../../app/models/persisters/active_record/term"

RSpec.describe Persisters::ActiveRecord::Term do
  it "uses strm as its primary key" do
    expect(described_class.primary_key).to eq("strm")
  end

  it "uses the ActiveRecord adapter" do
    expect(described_class.orm_adapter).to eq(Hexagram::Adapters::ActiveRecord)
  end
end
