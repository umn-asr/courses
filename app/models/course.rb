class Course < ::ActiveRecord::Base
  belongs_to :term
  belongs_to :campus

  validates_presence_of :term_id, :campus_id, :course_id
  validates_uniqueness_of :course_id, scope: [:term_id, :campus_id]

  attr_accessor :type

  self.primary_key = "id"

  def type
    "course"
  end
end
