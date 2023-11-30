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
      start_date: date_format(start_date),
      end_date: date_format(end_date),
      location: location.to_h,
      days: days.map { |d| d.to_h }
    }.delete_if { |_, value| value == {} }
  end

  private

  def date_format(date)
    date ? date.strftime("%Y-%m-%d") : nil
  end
end
