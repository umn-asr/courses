class ClassesPresenter < CoursesPresenter
  def to_h
    {
      campus: campus.to_h,
      term: term.to_h,
      courses: courses.map { |course| ClassOffering.fetch(course.id, cache).to_h }
    }
  end
end
