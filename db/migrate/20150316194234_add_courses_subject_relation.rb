class AddCoursesSubjectRelation < ActiveRecord::Migration
  def change
    # add_column :courses, :subject_id, :integer
    # add_foreign_key :courses, :subjects
    change_table :courses do |t|
      t.belongs_to :subject, index: true
    end
  end
end
