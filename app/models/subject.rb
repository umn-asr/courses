class Subject < ::ActiveRecord::Base
  has_many :courses

  validates_presence_of :subject_id, :description
  validates_uniqueness_of :subject_id

  def type
    "subject"
  end
end
