class Campus < ::ActiveRecord::Base
  validates_presence_of :abbreviation
  validates_uniqueness_of :abbreviation

  attr_accessor :type

  def self.orm_adapter
    ::Hexagram::Adapters::ActiveRecord
  end

  self.primary_key = "abbreviation"

  def type
    "campus"
  end
end
