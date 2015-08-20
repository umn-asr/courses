class EnrollmentService
  def self.fetch(class_number)
    [
      {
        type: "class",
        class_id: "#{class_number}",
        enrollmentCapacity: {
          "enrollmentSection": [true,false].sample,
          "enrollCapacity": rand(20),
          "waitCapacity": rand(20),
          "minEnrollment": rand(20),
          "enrollmentTotal": rand(20),
          "waitTotal": rand(20),
          "reserveCapacities": []
        }
      }
    ].detect { |x| x[:class_id] == class_number.to_s}
  end
end
