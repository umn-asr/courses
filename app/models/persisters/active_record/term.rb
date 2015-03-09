module Persisters
  module ActiveRecord
    class Term < ::ActiveRecord::Base
      attr_accessor :type

      def self.orm_adapter
        ::Hexagram::Adapters::ActiveRecord
      end

      self.primary_key = "strm"
    end
  end
end
