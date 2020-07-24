class AddCoursesSubjectRelation < ActiveRecord::Migration[5.2]
  def change
    change_table :courses do |t|
      t.belongs_to :subject, index: true
    end
  end
end
