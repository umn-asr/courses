class GradingBasis < ::ActiveRecord::Base
  has_many :sections

  validates_presence_of :grading_basis_id
  validates_uniqueness_of :grading_basis_id

  def type
    "grading_basis"
  end

  def to_h
    {
      type: type,
      grading_basis_id: grading_basis_id,
      id: id,
      description: description
    }
  end
end
