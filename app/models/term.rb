class Term < ::ActiveRecord::Base

  has_many :subjects, dependent: :destroy
  has_many :courses, through: :subject, dependent: :destroy

  validates_presence_of :strm
  validates_uniqueness_of :strm

  def type
    "term"
  end

  def term_id
    strm
  end
end
