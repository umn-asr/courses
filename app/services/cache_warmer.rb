class CacheWarmer
  def self.warm(cache)
    new(cache).warm
  end

  def initialize(cache)
    self.cache = cache
  end

  def warm
    clear_cache
    populate_cache
  end

  private
  attr_accessor :cache

  def clear_cache
    cache.clear
  end

  def populate_cache
    cache_terms
    cache_campuses
    cache_queryable_courses
    cache_full_courses
  end

  def cache_terms
    terms.each { |term| Term.fetch(term.strm, cache)}
  end

  def cache_campuses
    campuses.each { |campus| Campus.fetch(campus.abbreviation, cache) }
  end

  def cache_queryable_courses
    campuses_and_terms.each { |campus, term| QueryableCourses.fetch(campus, term, cache) }
  end

  def cache_full_courses
    Course.all.each do |c|
      Course.fetch(c.id, cache)
    end
  end

  def campuses_and_terms
    campuses.product(terms)
  end

  def terms
    Term.all
  end

  def campuses
    Campus.all
  end
end
