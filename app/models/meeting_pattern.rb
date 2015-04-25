class MeetingPattern < ::ActiveRecord::Base
  belongs_to :section
  belongs_to :location
  has_and_belongs_to_many :days

  def type
    "meeting_pattern"
  end

  def to_h
    {
      type: type,
      start_time: start_time,
      end_time: end_time,
      start_date: start_date,
      end_date: end_date,
      location: location.to_h,
      days: days.map { |d| d.to_h }
    }
  end
end
