module ReferenceTest
  def self.test_structure(actual, reference = reference_structure)
    if actual.respond_to?(:keys) || reference.respond_to?(:keys)
      raise ArgumentError if !actual.respond_to?(:keys)
      raise ArgumentError if !reference.respond_to?(:keys)
      raise ArgumentError if actual.keys != reference.keys

      actual.keys.each do |k|
        test_structure(actual[k], reference[k])
      end
    elsif actual.respond_to?(:each) || actual.respond_to?(:each)
      raise ArgumentError if !actual.respond_to?(:each)
      raise ArgumentError if !reference.respond_to?(:each)

      test_structure(actual.sample, reference.sample)
    else
      #noop
    end
  end

  def self.failure_message(actual, reference)
    "Actual: #{actual.inspect}, Reference: #{reference.inspect}"
  end

  def self.reference_structure
    {
      "campus" => {
        "type" => "campus",
        "id" => "UMNTC",
        "abbreviation" => "UMNTC"
      },
      "term" => {
        "type" => "term",
        "id" => "1149",
        "strm" => "1149"
      },
      "courses" => [
        {
          "type" => "course",
          "id" => 1,
          "catalog_number" => "12345"
        },
      ]
    }
  end
end
