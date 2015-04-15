class CoursesPresenter
  attr_accessor :campus, :term, :unfiltered_courses, :courses

  def self.retrieve(courses)
    courses.collect(&:cache_key).map { |key| Rails.cache.read(key) }
  end

  def self.fetch(campus_id, term_id)
    if Rails.cache.exist?("#{campus_id}_#{term_id}")
      presented_courses = self.new
      presented_courses.campus = Rails.cache.read(campus_id)
      presented_courses.term = Rails.cache.read(term_id)

      Rails.cache.read("#{campus_id}_#{term_id}_queryable").each_with_object(presented_courses.queryable_courses) { |k, c| c << Rails.cache.read(k) }

      presented_courses
    else
      course_cache_keys = []
      queryable_cache_keys = []

      presented_courses = self.new

      presented_courses.campus = Rails.cache.fetch(campus_id) do
        Campus.where(abbreviation: campus_id.upcase).first
      end

      presented_courses.term = Rails.cache.fetch(term_id) do
        Term.where(strm: term_id).first
      end

      presented_courses.unfiltered_courses = Course.for_campus_and_term(presented_courses.campus, presented_courses.term).collect do |course|
        presented_course = CoursePresenter.new(course)
        course_cache_keys << presented_course.cache_key
        queryable_cache_keys << "#{presented_course.cache_key}_queryable"
        Rails.cache.write(presented_course.cache_key, presented_course)
        Rails.cache.write("#{presented_course.cache_key}_queryable", presented_course.queryable)
        presented_courses.queryable_courses << presented_course.queryable
      end

      Rails.cache.write("#{campus_id}_#{term_id}_queryable", queryable_cache_keys)
      Rails.cache.write("#{campus_id}_#{term_id}", course_cache_keys)
      presented_courses
    end
  end

  def queryable_courses
    @queryable_course ||= []
  end
end
