class QueryableCourses
  def self.fetch(campus, term, cache = Rails.cache)
    if cache.exist?(cache_key(campus, term))
      cache.read(cache_key(campus,term)).map do |key|
        QueryableCourse.read(key)
      end
    else
      queryable_cache_keys = []

      Course.for_campus_and_term(campus, term).collect do |course|
        queryable_cache_keys << QueryableCourse.build(course).cache_key
      end

      cache.write(cache_key(campus, term), queryable_cache_keys)
      fetch(campus, term, cache)
    end
  end

  def self.cache_key(campus, term)
    "#{campus.cache_key}_#{term.cache_key}_queryable"
  end
end
