require 'json'

class EnrollmentService
  include HTTParty

  headers 'Content-Type' => 'application/json'
  base_uri 'esup-integration.oit.umn.edu/classSearchService/v1'

  def self.fetch(class_number, term_id)
    response = get("/enrollment/#{term_id}", query: {"classNumbers" => class_number}).body
    result = JSON.parse(response)
    c = result.detect { |x| x["classNumber"].to_s == class_number.to_s }
    Hash(c)
  end
end
