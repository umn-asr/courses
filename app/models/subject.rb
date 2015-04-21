class Subject < ::ActiveRecord::Base
  belongs_to :term
  belongs_to :campus
  has_many :courses, dependent: :destroy

  validates_presence_of :subject_id, :description, :campus_id, :term_id
  validates_uniqueness_of :subject_id, scope: [:campus, :term]

  def type
    "subject"
  end
end