require "rails_helper"
require_relative "../../../../app/models/models/active_record/campus"

RSpec.describe Models::ActiveRecord::Campus do
  it "uses abbreviation as its primary key" do
    expect(described_class.primary_key).to eq("abbreviation")
  end

  it "uses the ActiveRecord adapter" do
    expect(described_class.orm_adapter).to eq(Adapters::ActiveRecord)
  end
end
