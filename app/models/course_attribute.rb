class CourseAttribute < ::ActiveRecord::Base
  has_and_belongs_to_many :courses

  validates_presence_of :attribute_id, :family
  validates_uniqueness_of :attribute_id, scope: :family

  def type
    "attribute"
  end

  def to_h
    {
      type: type,
      attribute_id: attribute_id,
      id: id,
      family: family
    }
  end
end
