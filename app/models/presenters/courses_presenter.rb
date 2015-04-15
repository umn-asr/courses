class CoursesPresenter
  attr_accessor :campus, :term, :unfiltered_courses, :courses

  def self.fetch(campus_id, term_id)
    if Rails.cache.exist?("#{campus_id}_#{term_id}")
      p = self.new
      p.campus = Rails.cache.read(campus_id)
      p.term = Rails.cache.read(term_id)

      course_cache_keys = Rails.cache.read("#{campus_id}_#{term_id}")

      p.unfiltered_courses = course_cache_keys.map { |key| Rails.cache.read(key) }

      p
    else
      course_cache_keys = []

      p = self.new

      p.campus = Rails.cache.fetch(campus_id) do
        Campus.where(abbreviation: campus_id.upcase).first
      end

      p.term = Rails.cache.fetch(term_id) do
        Term.where(strm: term_id).first
      end

      p.unfiltered_courses = Course.for_campus_and_term(p.campus, p.term).collect do |course|
        presented_course = CoursePresenter.new(course)
        course_cache_keys << presented_course.cache_key
        Rails.cache.write(presented_course.cache_key, presented_course)
        presented_course
      end

      Rails.cache.write("#{campus_id}_#{term_id}", course_cache_keys)
      p
    end
  end
end
