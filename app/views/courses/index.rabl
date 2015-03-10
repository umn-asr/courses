object false
child(@campus) {attributes :type, :campus_id, :id, :abbreviation}
child(@term => :term) {attributes :type, :term_id, :id, :strm}
child(@courses => :courses) do
  collection @courses, :root => false, :object_root => false
  attributes :type, :course_id, :id, :catalog_number, :description, :title

  child :subject => :subject do
    attributes :type, :subject_id, :id, :description
  end

  child :attributes => :attributes do
    collection attributes, :root => false, :object_root => false
    attributes :type, :attribute_id, :id, :family
  end

  child :sections => :sections do
    collection attributes, :root => false, :object_root => false
    attributes :type, :id, :class_number, :number, :component, :location, :credits_maximum, :credits_minimum, :notes

    child :instruction_mode => :instruction_mode do
      attributes :type, :instruction_mode_id, :id, :description
    end

    child :grading_basis => :grading_basis do
      attributes :type, :grading_basis_id, :id, :description
    end

    child :instructors => :instructors do
      collection attributes, :root => false, :object_root => false
      attributes :type, :employee_id, :id, :name, :email, :role
    end

    child :meeting_patterns => :meeting_patterns do
      collection attributes, :root => false, :object_root => false
      attributes :type, :start_time, :end_time, :start_date, :end_date

      child :location => :location do
        attributes :type, :location_id, :id, :description
      end
    end
  end
end
