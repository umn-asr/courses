object false
child(@campus) {attributes :type, :campus_id, :id, :abbreviation}
child(@term => :term) {attributes :type, :term_id, :id, :strm}
child(@courses => :courses) do
  collection @courses, :root => false, :object_root => false
  attributes :type, :course_id, :id, :catalog_number, :description, :title, :subject, :attributes, :sections
end
