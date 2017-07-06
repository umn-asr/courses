class RemoveCourseTermId < ActiveRecord::Migration[5.0]
  def change
    remove_column(:courses, :term_id)
  end
end
