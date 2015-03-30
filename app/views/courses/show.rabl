object @course

attributes :type, :course_id, :id, :catalog_number, :description, :title

child :subject => :subject do
  extends "subjects/show"
end

child :equivalency, if: ->(course) { course.equivalency.present? } do
  attributes :type, :equivalency_id
end

child :cle_attributes => :cle_attributes do
  collection attributes, :root => false, :object_root => false
  attributes :type, :attribute_id, :id, :family
end

child :sections => :sections do
  collection attributes, :root => false, :object_root => false
  extends "sections/show"
end
