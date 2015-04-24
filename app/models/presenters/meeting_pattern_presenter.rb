class MeetingPatternPresenter
  extend Forwardable
  def_delegators :meeting_pattern, :type, :start_time, :end_time

  attr_accessor :location, :meeting_pattern, :days

  def initialize(ar_pattern)
    self.meeting_pattern = ar_pattern
    self.location = meeting_pattern.location
    self.days = meeting_pattern.days.map { |d| DayPresenter.new(d) }
  end

  def cache_key
    "#{meeting_pattern.type}_#{meeting_pattern.id}"
  end

  def start_date
    date_format(meeting_pattern.start_date)
  end

  def end_date
    date_format(meeting_pattern.end_date)
  end

  private
  def date_format(date)
    date.strftime('%Y-%m-%d')
  end

end
