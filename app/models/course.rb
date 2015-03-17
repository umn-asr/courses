class Course < ::ActiveRecord::Base
  belongs_to :term
  belongs_to :campus
  belongs_to :subject
  has_and_belongs_to_many :course_attributes

  validates_presence_of :term_id, :campus_id, :course_id
  validates_uniqueness_of :course_id, scope: [:term_id, :campus_id]

  attr_accessor :sections

  def type
    "course"
  end

  def cle_attributes
    course_attributes.where(family: "CLE")
  end
end
