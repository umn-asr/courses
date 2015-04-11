class MeetingPatternPresenter
  extend Forwardable
  def_delegators :meeting_pattern, :type, :start_time, :end_time, :start_date, :end_date

  attr_accessor :location, :meeting_pattern, :days

  def initialize(ar_pattern)
    self.meeting_pattern = ar_pattern
    self.location = meeting_pattern.location
    self.days = meeting_pattern.days.map { |d| DayPresenter.new(d) }
  end
end
