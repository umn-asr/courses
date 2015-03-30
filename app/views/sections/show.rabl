object @sections
cache @sections

attributes :type, :id, :class_number, :number, :component, :location, :credits_maximum, :credits_minimum, :notes

child :instruction_mode => :instruction_mode do
  attributes :type, :instruction_mode_id, :id, :description
end

child :grading_basis => :grading_basis do
  attributes :type, :grading_basis_id, :id, :description
end

child :instructors => :instructors do
  collection attributes, :root => false, :object_root => false
  attributes :type, :id, :name, :email, :role
end

child :meeting_patterns => :meeting_patterns do
  collection attributes, :root => false, :object_root => false
  attributes :type, :start_time, :end_time, :start_date, :end_date

  child :location => :location do
    attributes :type, :location_id, :id, :description
  end

  child :days => :days do
    collection attributes, :root => false, :object_root => false
    attributes :type, :name, :abbreviation
  end
end

child :combined_sections => :combined_sections do
  collection attributes, :root => false, :object_root => false
  attributes :type, :catalog_number, :subject_id, :section_number
end
