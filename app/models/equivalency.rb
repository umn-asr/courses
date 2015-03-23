class Equivalency < ActiveRecord::Base

  validates :equivalency_id, presence: true, uniqueness: true

  def type
    "equivalency"
  end
end