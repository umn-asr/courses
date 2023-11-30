class Equivalency < ActiveRecord::Base
  has_many :courses

  validates :equivalency_id, presence: true, uniqueness: true

  def type
    "equivalency"
  end

  def to_h
    {
      type: type,
      equivalency_id: equivalency_id
    }
  end
end
