class CoursesPresenter
  def self.fetch(campus, term, courses, cache = Rails.cache)
    new(campus, term, courses, cache)
  end

  def initialize(campus, term, courses, cache)
    self.campus = campus
    self.term = term
    self.courses = courses
    self.cache = cache
  end

  def to_h
    {
      campus: campus.to_h,
      term: term.to_h,
      courses: courses.map { |course| Course.fetch(course.id, cache).to_h }
    }
  end

  private

  attr_accessor :campus, :term, :courses, :cache
end
