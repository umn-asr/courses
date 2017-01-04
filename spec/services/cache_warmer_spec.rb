require "rails_helper"

RSpec.describe CacheWarmer do
  before :all do
    generate_terms
    generate_campuses
  end

  let(:cache)   { instance_double("ActiveSupport::Cache::Store") }
  let(:terms)     { Term.all.to_a }
  let(:campuses)  { Campus.all.to_a }
  subject       { described_class.new(cache, terms, campuses) }

  describe ".warm" do
    it "instantiates a new CacheWarmer with the supplied cache and calls #warm on it" do
      cache_warmer = instance_double(described_class)
      expect(described_class).to receive(:new).with(cache, terms, campuses).and_return(cache_warmer)
      expect(cache_warmer).to receive(:warm)

      described_class.warm(cache, terms, campuses)
    end
  end

  describe "warm" do
    before do
      allow(cache).to             receive(:clear)
      allow(Campus).to            receive(:fetch)
      allow(Term).to              receive(:fetch)
      allow(QueryableCourses).to  receive(:fetch)
      allow(QueryableClasses).to  receive(:fetch)
    end

    it "clears the cache" do
      expect(cache).to receive(:clear)
      subject.warm
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

    it "caches the queryable version of all courses and classes for each campus and term" do
      campuses.product(terms).each do |campus, term|
        expect(QueryableCourses).to receive(:fetch).with(campus, term, cache)
        expect(QueryableClasses).to receive(:fetch).with(campus, term, cache)
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
    nil
  end

  def generate_campuses
    campus_abbreviations = ["UMNCR", "UMNDL", "UMNMO", "UMNRO", "UMNTC"].take(rand(2..5))
    campus_abbreviations.map { |campus_abbreviation| Campus.new(abbreviation: campus_abbreviation)}
    nil
  end

  def generate_courses
    rand(5..10).times.map { Course.new(course_id: rand(11_111..99_999).to_s) }
  end
end
