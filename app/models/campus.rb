class Campus < ::ActiveRecord::Base
  validates_presence_of :abbreviation
  validates_uniqueness_of :abbreviation

  attr_accessor :type

  self.primary_key = "abbreviation"

  def type
    "campus"
  end
end
