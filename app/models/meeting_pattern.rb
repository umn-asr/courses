class MeetingPattern < ::ActiveRecord::Base
  belongs_to :section
  belongs_to :location
  has_and_belongs_to_many :days

  def type
    "meeting_pattern"
  end
end
