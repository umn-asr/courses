class AddCoursesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.belongs_to :campus, index: true
      t.belongs_to :term, index: true
      t.string :course_id
      t.string :title
      t.string :description
      t.string :catalog_number
    end
  end
end
