class Course < ::ActiveRecord::Base
  belongs_to :term
  belongs_to :campus
  belongs_to :subject
  belongs_to :equivalency
  has_and_belongs_to_many :course_attributes
  has_many :sections

  validates_presence_of :term_id, :campus_id, :course_id
  validates_uniqueness_of :course_id, scope: [:term_id, :campus_id]

  def type
    "course"
  end

  def cle_attributes
    course_attributes.where(family: "CLE")
  end

  def self.for_campus_and_term(campus, term)
    #Rails.cache.fetch("#{campus.id}_#{term.id}", expires_in: 12.hours) do
      self.where(campus_id: campus.id, term_id: term.id)
    #end
  end
end
