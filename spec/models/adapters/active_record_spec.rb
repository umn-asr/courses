require "rails_helper"
require_relative "../../../app/models/adapters/active_record"
require_relative "../../support/shared/adapter_spec"

RSpec.describe Adapters::ActiveRecord do
  it_behaves_like "an adapter"
end
