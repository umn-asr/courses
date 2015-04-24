class CoursesPresenter
  attr_accessor :campus, :term, :courses

  def self.fetch(campus, term, courses, cache = Rails.cache)
    presented_courses = self.new
    presented_courses.campus = campus
    presented_courses.term = term

    presented_courses.courses = courses.map { |course| CoursePresenter.fetch(course, cache) }
    presented_courses
  end
end
