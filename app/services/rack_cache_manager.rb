class RackCacheManager
  include Rails.application.routes.url_helpers

  def self.reset(terms, campuses)
    manager = new(terms, campuses)
    manager.clear
    manager.warm
  end

  def initialize(terms, campuses)
    self.terms = terms
    self.campuses = campuses
  end

  def clear
    cache_folders.each do |folder|
      FileUtils.rm_rf(folder)
    end
  end

  def warm(urls=base_urls_to_cache)
    urls.each do |url|
      `curl #{url}`
    end
  end

  private

  attr_accessor :terms, :campuses

  def cache_folders
    ["#{Rails.root}/tmp/cache/rack/meta", "#{Rails.root}/tmp/cache/rack/body"]
  end

  def base_urls_to_cache
    campuses.product(terms).inject([]) do |array, (campus, term)|
      array << campus_term_courses_url(campus.abbreviation, term.strm, format: :xml)
      array << campus_term_courses_url(campus.abbreviation, term.strm, format: :json)
      array
    end
  end
end
