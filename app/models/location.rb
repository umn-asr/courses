class Location < ::ActiveRecord::Base
  has_many :meeting_patterns

  def type
    "location"
  end

  def to_h
    {
      type: type,
      location_id: location_id,
      id: id.to_s,
      description: description
    }
  end
end
