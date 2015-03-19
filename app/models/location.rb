class Location < ::ActiveRecord::Base
  has_many :meeting_patterns

  def type
    "location"
  end
end
