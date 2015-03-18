class AddSubjectsTable < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :subject_id
      t.string :description
    end
  end
end
