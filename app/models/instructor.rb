class Instructor < ::ActiveRecord::Base
  belongs_to :instructor_role
  belongs_to :instructor_contact

  def type
    "instructor"
  end
end
