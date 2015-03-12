class Campus < ::ActiveRecord::Base
  validates_presence_of :abbreviation
  validates_uniqueness_of :abbreviation

  has_many :courses, dependent: :destroy

  def type
    "campus"
  end

  def campus_id
    abbreviation
  end
end
