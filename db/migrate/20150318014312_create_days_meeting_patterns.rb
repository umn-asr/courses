class CreateDaysMeetingPatterns < ActiveRecord::Migration
  def change
    create_table :days_meeting_patterns, id: false do |t|
      t.belongs_to :day, index: true
      t.belongs_to :meeting_pattern, index: true
    end
  end
end
