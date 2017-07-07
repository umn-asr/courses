class RemoveCampusIdAndTermIdFromCourses < ActiveRecord::Migration
  def change
    remove_reference :courses, :campus, index: true
    remove_reference :courses, :term, index: true
  end
end
