class Location < ::ActiveRecord::Base
  has_many :meeting_patterns

  def type
    "location"
  end

  def to_h
    {
      type: type,
      location_id: location_id,
      id: id,
      description: description
    }
  end
end
