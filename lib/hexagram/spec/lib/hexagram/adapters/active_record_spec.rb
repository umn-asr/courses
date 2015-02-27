require_relative "../../../../lib/hexagram/adapters/active_record"
require_relative "../../../shared/adapter"

RSpec.describe Hexagram::Adapters::ActiveRecord do
  it_behaves_like "an adapter"
end
