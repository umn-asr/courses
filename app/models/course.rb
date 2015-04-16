class Course < ::ActiveRecord::Base
  belongs_to :subject
  belongs_to :equivalency
  has_and_belongs_to_many :course_attributes
  has_many :sections

  delegate :term, :campus, to: :subject

  validates_presence_of :subject_id, :course_id
  validates_uniqueness_of :course_id, scope: [:subject_id]

  scope :for_campus_and_term, ->(campus, term) { joins(:subject).where(subjects: { campus_id: campus.id, term_id: term.id }) }

  def self.cache_key_for_instance(course)
    "#{type}_#{course.id}"
  end

  def self.type
    "course"
  end

  def type
    self.class.type
  end

  def cache_key
    self.class.cache_key_for_instance(self)
  end
end
