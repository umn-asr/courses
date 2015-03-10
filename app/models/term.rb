class Term < ::ActiveRecord::Base
  validates_presence_of :strm
  validates_uniqueness_of :strm

  attr_accessor :type

  def type
    "term"
  end
end
