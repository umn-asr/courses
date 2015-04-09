class Campus < ::ActiveRecord::Base

  has_many :subjects, dependent: :destroy
  has_many :courses, through: :subjects, dependent: :destroy

  validates_presence_of :abbreviation
  validates_uniqueness_of :abbreviation


  def type
    "campus"
  end

  def campus_id
    abbreviation
  end
end
