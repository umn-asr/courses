class Course < ::ActiveRecord::Base
  belongs_to :subject
  belongs_to :equivalency
  has_and_belongs_to_many :course_attributes
  has_many :sections

  delegate :term, :campus, to: :subject

  validates_presence_of :subject_id, :course_id
  validates_uniqueness_of :course_id, scope: [:subject_id]

  scope :for_campus_and_term, ->(campus, term) { joins(:subject).where(subjects: { campus_id: campus.id, term_id: term.id }) }

  def type
    "course"
  end

  def cle_attributes
    course_attributes.where(family: "CLE")
  end

end
