class Term < ::ActiveRecord::Base
  has_many :courses, dependent: :destroy

  validates_presence_of :strm
  validates_uniqueness_of :strm

  attr_accessor :type

  def type
    "term"
  end

  def term_id
    strm
  end
end
