class CreateMeetingPatterns < ActiveRecord::Migration
  def change
    create_table :meeting_patterns do |t|
      t.belongs_to :section
      t.string :start_time
      t.string :end_time
      t.date :start_date
      t.date :end_date
    end
  end
end
