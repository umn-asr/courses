class CacheWarmer
  def self.warm(cache, terms, campuses)
    new(cache, terms, campuses).warm
  end

  def initialize(cache, terms, campuses)
    self.cache = cache
    self.terms = terms
    self.campuses = campuses
  end

  def warm
    clear_cache
    populate_cache
  end

  private

  attr_accessor :cache, :terms, :campuses

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
    terms.each { |term| Term.fetch(term.strm, cache) }
  end

  def cache_campuses
    campuses.each { |campus| Campus.fetch(campus.abbreviation, cache) }
  end

  def cache_queryable_courses
    campuses_and_terms.each do |campus, term|
      QueryableCourses.fetch(campus, term, cache)
      QueryableClasses.fetch(campus, term, cache)
    end
  end

  def cache_full_courses
    Course.all.each do |c|
      Course.fetch(c.id, cache)
    end
  end

  def campuses_and_terms
    campuses.product(terms)
  end
end
