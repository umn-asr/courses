class CoursesPresenter
  attr_accessor :campus, :term, :all_courses, :courses

  def self.fetch(campus_id, term_id)
    unless Rails.cache.exist?("#{campus_id}_#{term_id}")
      p = self.new

      p.campus = Campus.where(abbreviation: campus_id.upcase).first
      p.term = Term.where(strm: term_id).first

      p.all_courses = Course.for_campus_and_term(p.campus, p.term).map { |x| CoursePresenter.new(x) }
      Rails.cache.write("#{campus_id}_#{term_id}", p)
    end
    Rails.cache.fetch("#{campus_id}_#{term_id}")
  end
end
