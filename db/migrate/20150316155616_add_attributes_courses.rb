class AddAttributesCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :course_attributes_courses, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :course_attribute, index: true
    end
  end
end
