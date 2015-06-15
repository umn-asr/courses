class ClassOffering < Course
  self.inheritance_column = :_type_disabled

  scope :all_for_campus_and_term, ->(campus, term) { joins(:sections).joins(:subject).where(subjects: { campus_id: campus.id, term_id: term.id }).order('subjects.description, courses.catalog_number') }

  def self.for_campus_and_term(campus, term)
    #all_for_campus_and_term returns 1 row per section. to_set removes the duplicates.
    #the ActiveRecord method `distinct` will fail in Oracle because of the campus.description field being a CLOB
    all_for_campus_and_term(campus,term).to_set
  end
end
