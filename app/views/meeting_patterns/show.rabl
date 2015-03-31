object @meeting_pattern
cache @meeting_pattern

attributes :type, :start_time, :end_time, :start_date, :end_date

child :location => :location do
  extends "locations/show"
end

child :days => :days do
  collection attributes, :root => false, :object_root => false
  extends "days/show"
end
