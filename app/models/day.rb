class Day < ::ActiveRecord::Base
  has_and_belongs_to_many :meeting_patterns

  def type
    "day"
  end
end
