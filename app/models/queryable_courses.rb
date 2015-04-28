class QueryableCourses
  def self.fetch(campus, term, rails_cache = Rails.cache)
    FastCache.fetch(cache_key(campus, term)) do
      rails_cache.fetch(cache_key(campus, term)) do
        Course.for_campus_and_term(campus, term).collect do |course|
          QueryableCourse.new(course)
        end
      end
    end
  end

  def self.cache_key(campus, term)
    "#{campus.cache_key}_#{term.cache_key}_queryable"
  end
end
