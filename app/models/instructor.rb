class Instructor < ::ActiveRecord::Base
  belongs_to :instructor_role
  belongs_to :instructor_contact

  def type
    "instructor"
  end

  def name
    instructor_contact.name
  end

  def email
    instructor_contact.email
  end

  def role
    instructor_role.abbreviation
  end
end
