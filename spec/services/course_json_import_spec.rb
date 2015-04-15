require "rails_helper"
require "json"

RSpec.describe CourseJsonImport, :type => :request do
  let (:course_json) { JSON.parse(File.read('test/fixtures/courses_example.json')) }

  subject { described_class.new(course_json) }

  describe "run" do
    before do
      %w(UMNTC UMNDL UMNMO UMNCR UMNRO).each do |abbreviation|
        Campus.create({abbreviation: abbreviation})
      end

      %w(1149 1153 1155 1159 1163).each do |strm|
        Term.create({strm: strm})
      end

      {"m" => "Monday", "t" => "Tuesday", "w" => "Wednesday", "th" => "Thursday", "f" => "Friday", "sa" => "Saturday", "su" => "Sunday"}.each do |abbreviation, name|
        Day.create(abbreviation: abbreviation, name: name)
      end
    end

    it "persits the json" do
      # sanity check - make sure we are starting from scratch
      get "/campuses/UMNTC/terms/1149/courses", { :format => :json }
      expect(JSON.parse(response.body)["courses"]).to eq([])

      subject.run
      get "/campuses/UMNTC/terms/1149/courses", { :format => :json }
      response_json = JSON.parse(response.body)
      format_for_comparison!(response_json)
      format_for_comparison!(course_json)

      expect(sort_json!(response_json)).to eq(sort_json!(course_json))
    end
  end

  def sort_json!(class_json)
    class_json["courses"].sort_by! { |course| course["course_id"] }
    class_json["courses"].each do |course|
      course["course_attributes"].sort_by! { |course_attribute| course_attribute["attribute_id"] }
      course["sections"].sort_by! { |section| section["number"] }
      course["sections"].each do |section|
        section["instructors"].sort_by! { |instructor| instructor["name"] }
        section["meeting_patterns"].sort_by! { |pattern| pattern["start_date"] }
        section["meeting_patterns"].each do |pattern|
          pattern["days"].sort_by! { |day| day["name"] }
        end
        section["combined_sections"].sort_by! { |combined_section| combined_section["catalog_number"]}
      end
    end
  end

  def format_for_comparison!(json)
    if json.class == Hash
      json.delete_if { |key, value| key == "id" }
      json.values.each do |value|
        value = value.downcase! if value.class == String
        format_for_comparison!(value)
      end
    elsif json.class == Array
      json.each { |sub_item| format_for_comparison!(sub_item)}
    end
    json
  end

end
