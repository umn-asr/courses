class QueryableCourses
  def self.fetch(campus, term)
    if Rails.cache.exist?(cache_key(campus, term))
      Rails.cache.read(cache_key(campus,term)).map do |key|
        QueryableCourse.read(key)
      end
    else
      queryable_cache_keys = []

      Course.for_campus_and_term(campus, term).collect do |course|
        queryable_cache_keys << QueryableCourse.build(course).cache_key
      end

      Rails.cache.write(cache_key(campus, term), queryable_cache_keys)
      fetch(campus, term)
    end
  end

  def self.cache_key(campus, term)
    "#{campus.cache_key}_#{term.cache_key}_queryable"
  end
end
