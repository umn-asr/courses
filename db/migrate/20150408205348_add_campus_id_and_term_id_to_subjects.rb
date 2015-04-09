class AddCampusIdAndTermIdToSubjects < ActiveRecord::Migration
  def change
    add_reference :subjects, :campus, index: true
    add_foreign_key :subjects, :campuses
    add_reference :subjects, :term, index: true
    add_foreign_key :subjects, :terms
  end
end
