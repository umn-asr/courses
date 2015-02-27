module Hexagram
  module Repositories; end
end
Dir.glob(File.join(File.dirname(__FILE__), "repositories", "*.rb")) { |file| require file }
