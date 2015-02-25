module Storage
  module Models
    module ActiveRecord
      class Campus < ::ActiveRecord::Base
        self.primary_key = "abbreviation"
      end
    end
  end
end
