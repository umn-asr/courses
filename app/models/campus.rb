class Campus < ::ActiveRecord::Base

  has_many :subjects, dependent: :destroy
  has_many :courses, through: :subjects, dependent: :destroy

  validates_presence_of :abbreviation
  validates_uniqueness_of :abbreviation

  def self.fetch(campus_id, cache = Rails.cache)
    cache.fetch(cache_key_for_instance(campus_id)) do
      Campus.where(abbreviation: campus_id.upcase).first
    end
  end

  def self.cache_key_for_instance(campus_id)
    "#{type}_#{campus_id.upcase}"
  end

  def self.type
    "campus"
  end

  def type
    self.class.type
  end

  def cache_key
    self.class.cache_key_for_instance(campus_id)
  end

  def campus_id
    abbreviation
  end
end
