object @sections
cache @sections

attributes :type, :id, :class_number, :number, :component, :location, :credits_maximum, :credits_minimum, :notes

child :instruction_mode => :instruction_mode do
  extends "instruction_modes/show"
end

child :grading_basis => :grading_basis do
  extends "grading_bases/show"
end

child :instructors => :instructors do
  collection attributes, :root => false, :object_root => false
  extends "instructors/show"
end

child :meeting_patterns => :meeting_patterns do
  collection attributes, :root => false, :object_root => false
  extends "meeting_patterns/show"
end

child :combined_sections => :combined_sections do
  collection attributes, :root => false, :object_root => false
  extends "combined_sections/show"
end
