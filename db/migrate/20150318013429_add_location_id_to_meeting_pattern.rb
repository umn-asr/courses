class AddLocationIdToMeetingPattern < ActiveRecord::Migration
  def change
    add_belongs_to(:meeting_patterns, :location)
  end
end
