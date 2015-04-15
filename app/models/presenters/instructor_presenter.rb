class InstructorPresenter
  attr_accessor :instructor_role, :instructor_contact, :instructor

  def initialize(ar_instructor)
    self.instructor = ar_instructor
    self.instructor_role = ar_instructor.instructor_role
    self.instructor_contact = ar_instructor.instructor_contact
  end

  def cache_key
    instructor.id
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
