class CoursesPresenter
  attr_accessor :campus, :term, :courses

  def self.fetch(campus, term, courses, cache = Rails.cache)
    {
      campus: campus.to_h,
      term: term.to_h,
      courses: courses.map { |course| Course.fetch(course.id, cache).to_h }
    }
  end
end
