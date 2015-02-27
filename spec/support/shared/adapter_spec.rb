RSpec.shared_examples "an adapter" do
  it "responds to the required methods" do
    [:find, :each, :build, :exists?, :where, :save].each do |method|
      expect(described_class).to respond_to(method)
    end
  end
end
