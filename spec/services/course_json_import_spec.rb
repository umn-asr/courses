require "rails_helper"
require "json"

RSpec.describe CourseJsonImport, :type => :request do
  let (:course_json) { JSON.parse(File.read('test/fixtures/courses_example.json')) }

  subject { described_class.new(course_json) }

  describe "run" do
    before do
      setup_cross_term_data
      ensure_no_courses
    end

    it "persits the json" do
      subject.run
      get "/campuses/UMNTC/terms/1149/courses", { :format => :json }
      response_json = JSON.parse(response.body)
      format_for_comparison!(response_json)
      format_for_comparison!(course_json)

      expect(sort_json!(response_json)).to eq(sort_json!(course_json))
    end

    describe "when a course is missing required data" do
      before do
        @course_id_not_imported = course_json["courses"].first["course_id"]
      end

      def import_and_get_imported_course_ids(json)
        subject = described_class.new(json)
        subject.run

        get "/campuses/UMNTC/terms/1149/courses", { :format => :json }
        response_json = JSON.parse(response.body)

        response_json["courses"].collect { |c| c["course_id"] }
      end

      it "does not import a course that is missing course_id" do
        course_json["courses"].first["course_id"] = nil

        imported_course_ids = import_and_get_imported_course_ids(course_json)

        expect(imported_course_ids).not_to include(@course_id_not_imported)
      end

      it "does not import a course that is missing its title" do
        course_json["courses"].first["title"] = nil

        imported_course_ids = import_and_get_imported_course_ids(course_json)

        expect(imported_course_ids).not_to include(@course_id_not_imported)
      end

      it "does not import a course that is missing its subject" do
        course_json["courses"].first.delete("subject")
        imported_course_ids = import_and_get_imported_course_ids(course_json)

        expect(imported_course_ids).not_to include(@course_id_not_imported)
      end
    end

    context "when a section is missing a grading basis" do
      let(:json_without_grading_basis) { JSON.parse(File.read('test/fixtures/no_grading_basis_for_section_102.json')) }
      subject { described_class.new(json_without_grading_basis)}

      it "persits the json" do
        subject.run
        get "/campuses/UMNTC/terms/1149/courses", { :format => :json }
        response_json = JSON.parse(response.body)
        format_for_comparison!(response_json)
        format_for_comparison!(json_without_grading_basis)

        expect(sort_json!(response_json)).to eq(sort_json!(json_without_grading_basis))
      end
    end

    context "when a section is missing an instruction mode" do
      let(:json_without_instruction_mode) { JSON.parse(File.read('test/fixtures/no_instruction_mode_for_section_104.json')) }
      subject { described_class.new(json_without_instruction_mode)}

      it "persits the json" do
        subject.run
        get "/campuses/UMNTC/terms/1149/courses", { :format => :json }
        response_json = JSON.parse(response.body)
        format_for_comparison!(response_json)
        format_for_comparison!(json_without_instruction_mode)

        expect(sort_json!(response_json)).to eq(sort_json!(json_without_instruction_mode))
      end

    end
  end

  def ensure_no_courses
    # sanity check - make sure we are starting from scratch
    get "/campuses/UMNTC/terms/1149/courses", { :format => :json }
    expect(JSON.parse(response.body)["courses"]).to eq([])
  end

  def setup_cross_term_data
    %w(UMNTC UMNDL UMNMO UMNCR UMNRO).each do |abbreviation|
      Campus.create({abbreviation: abbreviation})
    end

    %w(1149 1153 1155 1159 1163).each do |strm|
      Term.create({strm: strm})
    end

    {"m" => "Monday", "t" => "Tuesday", "w" => "Wednesday", "th" => "Thursday", "f" => "Friday", "sa" => "Saturday", "su" => "Sunday"}.each do |abbreviation, name|
      Day.create(abbreviation: abbreviation, name: name)
    end

    CourseAttributeJsonImport.new(course_json).run
    EquivalencyJsonImport.new(course_json).run
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
