class CreateMeetingPatterns < ActiveRecord::Migration[5.2]
  def change
    create_table :meeting_patterns do |t|
      t.belongs_to :section
      t.string :start_time
      t.string :end_time
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
