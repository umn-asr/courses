class DayPresenter
  extend Forwardable
  def_delegators :day, :type, :name, :abbreviation
  attr_accessor :day

  def cache_key
    "#{day.type}_#{day.id}"
  end

  def initialize(ar_day)
    self.day = ar_day
  end
end
