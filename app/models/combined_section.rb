class CombinedSection < ::ActiveRecord::Base
  belongs_to :section

  def type
    "combined_section"
  end

  def to_h
    {
      type: type,
      catalog_number: catalog_number,
      subject_id: subject_id,
      section_number: section_number
    }
  end
end
