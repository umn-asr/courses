class AddCoursesSubjectRelation < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.belongs_to :subject, index: true
    end
  end
end
