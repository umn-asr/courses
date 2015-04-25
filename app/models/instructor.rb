class Instructor < ::ActiveRecord::Base
  belongs_to :instructor_role
  belongs_to :instructor_contact

  def type
    "instructor"
  end

  def to_h
    {
      type: type,
      name: instructor_contact.name,
      email: instructor_contact.email,
      role: instructor_role.abbreviation
    }
  end
end
