object false
child(@campus) {attributes :type, :id, :abbreviation}
child(@term => :term) {attributes :type, :id, :strm}
child(@courses => :courses) do
  collection @courses, :root => false, :object_root => false
  attributes :type, :id, :catalog_number, :description, :title, :subject, :attributes, :sections
end
