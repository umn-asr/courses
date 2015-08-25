class GradingBasis < ::ActiveRecord::Base
  has_many :courses

  validates_presence_of :grading_basis_id
  validates_uniqueness_of :grading_basis_id

  def type
    "grading_basis"
  end

  def to_h
    {
      type: type,
      grading_basis_id: grading_basis_id,
      id: id.to_s,
      description: description
    }
  end
end
