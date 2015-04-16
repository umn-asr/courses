class CombinedSectionPresenter
  extend Forwardable
  def_delegators :combined_section, :catalog_number, :subject_id, :section_number, :type
  attr_accessor :combined_section

  def cache_key
    combined_section.id
  end

  def initialize(ar_combined_section)
    self.combined_section = ar_combined_section
  end
end
