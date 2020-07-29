class AddLocationIdToMeetingPattern < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to(:meeting_patterns, :location)
  end
end
