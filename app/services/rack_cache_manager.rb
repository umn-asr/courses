class RackCacheManager
  include Rails.application.routes.url_helpers

  def self.reset
    manager = new
    manager.clear
    manager.warm
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
  def cache_folders
    ["#{Rails.root}/tmp/cache/rack/meta", "#{Rails.root}/tmp/cache/rack/body"]
  end

  def base_urls_to_cache
    campuses = Campus.all
    terms    = Term.all
    formats  = [:xml, :json]

    campuses.product(terms).inject([]) do |array, (campus, term)|
      array << campus_term_courses_url(campus.abbreviation, term.strm, format: :xml)
      array << campus_term_courses_url(campus.abbreviation, term.strm, format: :json)
      array
    end
  end

end