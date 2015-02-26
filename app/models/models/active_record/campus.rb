module Models
  module ActiveRecord
    class Campus < ::ActiveRecord::Base

      def self.orm_adapter
        Adapters::ActiveRecord
      end

      self.primary_key = "abbreviation"
    end
  end
end
