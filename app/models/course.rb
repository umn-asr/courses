class Course < ::ActiveRecord::Base
  belongs_to :term
  belongs_to :campus
  has_and_belongs_to_many :subjects

  validates_presence_of :term_id, :campus_id, :course_id
  validates_uniqueness_of :course_id, scope: [:term_id, :campus_id]

  attr_accessor :subject, :cle_attributes, :sections

  def type
    "course"
  end
end
