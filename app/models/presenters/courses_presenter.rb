class CoursesPresenter
  attr_accessor :campus, :term, :courses

  def self.fetch(campus, term, courses)
    presented_courses = self.new
    presented_courses.campus = campus
    presented_courses.term = term

    presented_courses.courses = courses.map { |course| CoursePresenter.fetch(course) }
    presented_courses
  end
end
