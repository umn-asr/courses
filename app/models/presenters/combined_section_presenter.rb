class CombinedSectionPresenter
  extend Forwardable
  def_delegators :combined_section, :catalog_number, :subject_id, :section_number
  attr_accessor :combined_section

  def initialize(ar_combined_section)
    self.combined_section = ar_combined_section
  end
end
