module Hexagram
  module Adapters; end
end
Dir.glob(File.join(File.dirname(__FILE__), "adapters", "*.rb")) { |file| require file }
