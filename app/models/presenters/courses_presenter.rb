class CoursesPresenter
  attr_accessor :campus, :term, :courses

  def self.fetch(campus, term, courses, cache = Rails.cache)
    presented_courses = self.new
    presented_courses.campus = campus.to_h
    presented_courses.term = term.to_h

    presented_courses.courses = courses.map { |course| Course.fetch(course.id, cache) }
    presented_courses
  end
end
