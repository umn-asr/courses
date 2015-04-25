class Term < ::ActiveRecord::Base

  has_many :subjects, dependent: :destroy
  has_many :courses, through: :subjects, dependent: :destroy

  validates_presence_of :strm
  validates_uniqueness_of :strm

  def self.fetch(term_id, cache = Rails.cache)
    cache.fetch(cache_key_for_instance(term_id)) do
      Term.where(strm: term_id.upcase).first
    end
  end

  def self.cache_key_for_instance(term_id)
    "#{type}_#{term_id.upcase}"
  end

  def self.type
    "term"
  end

  def type
    self.class.type
  end

  def cache_key
    self.class.cache_key_for_instance(term_id)
  end

  def term_id
    strm
  end

  def to_h
    {
      type: type,
      term_id: term_id,
      strm: strm
    }
  end
end
