class CourseAttributesPresenter
  include Enumerable
  extend Forwardable
  def_delegators :collection, :each

  attr_accessor :collection

  def initialize(ar_attributes)
    ar_attributes.each_with_object(self.collection) { |a, c| c << a}
  end

  def collection
    @collection ||= []
  end
end
