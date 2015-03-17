class CourseAttribute < ::ActiveRecord::Base
  has_and_belongs_to_many :courses

  validates_presence_of :attribute_id, :family
  validates_uniqueness_of :attribute_id

  def type
    "attribute"
  end
end
