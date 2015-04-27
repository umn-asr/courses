require "rails_helper"

RSpec.describe CacheWarmer do
  let(:cache)   { instance_double("ActiveSupport::Cache::Store") }
  subject       { described_class.new(cache) }

  describe ".warm" do
    it "instantiates a new CacheWarmer with the supplied cache and calls #warm on it" do
      cache_warmer = instance_double(described_class)
      expect(described_class).to receive(:new).with(cache).and_return(cache_warmer)
      expect(cache_warmer).to receive(:warm)

      described_class.warm(cache)
    end

  end

  describe "warm" do
    let(:terms)     { generate_terms }
    let(:campuses)  { generate_campuses }

    before do
      allow(Campus).to            receive(:all).and_return(campuses)
      allow(Term).to              receive(:all).and_return(terms)
      allow(Campus).to            receive(:fetch)
      allow(Term).to              receive(:fetch)
      allow(QueryableCourses).to  receive(:fetch)
    end

    it "caches all terms with its cache" do
      terms.each do |term|
        expect(Term).to receive(:fetch).with(term.strm, cache)
      end
      subject.warm
    end

    it "caches all campuses" do
      campuses.each do |campus|
        expect(Campus).to receive(:fetch).with(campus.abbreviation, cache)
      end
      subject.warm
    end

    it "caches the queryable version of all courses for each campus and term" do
      campuses.product(terms).each do |campus, term|
        expect(QueryableCourses).to receive(:fetch).with(campus, term, cache)
      end

      subject.warm
    end

    it "caches the full version of the all the courses" do
      courses = generate_courses
      allow(Course).to receive(:all).and_return(courses)
      courses.each do |course|
        expect(Course).to receive(:fetch).with(course.id, cache)
      end

      subject.warm
    end
  end

  def generate_terms
    this_year = Time.now.strftime('%y').to_i
    years = (this_year..99).take(rand(3..6))
    years.flat_map { |year| ["1#{year}3", "1#{year}5", "1#{year}9"] }.map { |strm| Term.new(strm: strm)}
  end

  def generate_campuses
    campus_abbreviations = ["UMNCR", "UMNDL", "UMNMO", "UMNRO", "UMNTC"].take(rand(2..5))
    campus_abbreviations.map { |campus_abbreviation| Campus.new(abbreviation: campus_abbreviation)}
  end

  def generate_courses
    rand(5..10).times.map { Course.new(course_id: rand(11_111..99_999).to_s) }
  end
end
