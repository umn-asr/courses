class CombinedSection < ::ActiveRecord::Base
  belongs_to :section

  def type
    "combined_section"
  end
end
