object @course
cache @course

attributes :type, :course_id, :id, :catalog_number, :description, :title

child :subject => :subject do
  extends "subjects/show"
end

child :equivalency, if: ->(course) { course.equivalency.present? } do
  extends "equivalencies/show"
end

child :course_attributes => :course_attributes do
  collection attributes, :root => false, :object_root => false
  extends "attributes/show"
end

child :sections => :sections do
  collection attributes, :root => false, :object_root => false
  extends "sections/show"
end
