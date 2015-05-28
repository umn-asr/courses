class Course < ::ActiveRecord::Base
  belongs_to :subject
  belongs_to :equivalency
  has_and_belongs_to_many :course_attributes
  has_many :sections

  delegate :term, :campus, to: :subject

  validates_presence_of :subject_id, :course_id
  validates_uniqueness_of :course_id, scope: [:subject_id]

  scope :for_campus_and_term, ->(campus, term) { joins(:subject).where(subjects: { campus_id: campus.id, term_id: term.id }).order('subjects.description, courses.catalog_number') }

  def self.cache_key_for_instance(id)
    "#{type}_#{id}"
  end

  def self.type
    "course"
  end

  def self.fetch(id, cache = Rails.cache)
    cache.fetch(cache_key_for_instance(id)) do
      Course.find(id).to_h
    end
  end

  def type
    self.class.type
  end

  def cache_key
    self.class.cache_key_for_instance(self)
  end

  def to_h
    {
      type: type,
      course_id: course_id,
      id: id,
      catalog_number: catalog_number,
      description: description,
      title: title,
      subject: subject.to_h,
      equivalency: equivalency.to_h,
      course_attributes: course_attributes.map { |ca| ca.to_h },
      sections: sections.map { |s| s.to_h }
    }.delete_if { |_, value| value == {} }
  end
end
