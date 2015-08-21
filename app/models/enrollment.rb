class Enrollment
  attr_accessor :enrollment_capacity, :waitlist_capacity, :minimum_enrollment, :enrollment_total, :waitlist_total

  def self.fetch(section)
    enrollment_data = EnrollmentService.fetch(section.class_number, section.course.term.strm)
    new(Hash(enrollment_data))
  end

  def initialize(attrs = {})
    self.enrollment_capacity = attrs["enrollCapacity"]
    self.waitlist_capacity   = attrs["waitCapacity"]
    self.minimum_enrollment  = attrs["minEnrollment"]
    self.enrollment_total    = attrs["enrollmentTotal"]
    self.waitlist_total      = attrs["waitTotal"]
    self.status              = attrs["enrollStatus"]
  end

  def type
    "enrollment"
  end

  def status=(x)
    case x
    when "O"
      @status = "open"
    when "W"
      @status = "waitlist"
    when "C"
      @status = "closed"
    else
      @status = ""
    end
  end

  def to_h
    {
      type: type,
      enrollment_capacity: enrollment_capacity,
      waitlist_capacity: waitlist_capacity,
      minimum_enrollment: minimum_enrollment,
      enrollment_total: enrollment_total,
      waitlist_total: waitlist_total,
      status: status,
      reserve_capacities: []
    }
  end
end
