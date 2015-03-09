class Term < ::ActiveRecord::Base
  validates_presence_of :strm
  validates_uniqueness_of :strm

  attr_accessor :type

  self.primary_key = "strm"

  def type
    "term"
  end
end
