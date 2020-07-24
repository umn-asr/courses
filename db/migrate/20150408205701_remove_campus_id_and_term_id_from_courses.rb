class RemoveCampusIdAndTermIdFromCourses < ActiveRecord::Migration[5.2]
  def change
    remove_reference :courses, :campus, index: true
    remove_foreign_key :courses, :campuses
    remove_reference :courses, :term, index: true
    remove_foreign_key :courses, :terms
  end
end
