class ClassOffering < Course
  scope :for_campus_and_term, ->(campus, term) { joins(:sections).joins(:subject).where(subjects: { campus_id: campus.id, term_id: term.id }).order('subjects.description, courses.catalog_number') }
end
