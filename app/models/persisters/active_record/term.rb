module Persisters
  module ActiveRecord
    class Term < ::ActiveRecord::Base
      validates_presence_of :strm
      validates_uniqueness_of :strm

      attr_accessor :type

      def self.orm_adapter
        ::Hexagram::Adapters::ActiveRecord
      end

      self.primary_key = "strm"

      def type
        "term"
      end
    end
  end
end
