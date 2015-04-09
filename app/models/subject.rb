class Subject < ::ActiveRecord::Base
  belongs_to :term
  belongs_to :campus
  has_many :courses, dependent: :destroy

  validates_presence_of :subject_id, :description
  validates_uniqueness_of :subject_id

  def type
    "subject"
  end
end
