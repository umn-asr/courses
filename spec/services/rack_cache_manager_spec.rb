require 'rails_helper'

RSpec.describe RackCacheManager do
  include Rails.application.routes.url_helpers

  subject { described_class.new }

  describe ".reset" do
    it "builds a new RackCacheManager, then calls clear and warm" do
      instance = instance_double(described_class)
      expect(RackCacheManager).to receive(:new).and_return(instance)
      expect(instance).to receive(:clear)
      expect(instance).to receive(:warm)
      RackCacheManager.reset
    end
  end

  describe "#clear" do
    before do
      `mkdir -p #{Rails.root}/tmp/cache/rack/body/te`
      `touch #{Rails.root}/tmp/cache/rack/body/te/a-cache-file`
      `mkdir -p #{Rails.root}/tmp/cache/rack/meta/st`
      `touch #{Rails.root}/tmp/cache/rack/meta/st/a-cache-file`
    end

    after do
      `rm -rf #{Rails.root}/tmp/cache/rack/*`
    end

    it "removes files from the file cache directories" do
      cache_dir = Dir.new("#{Rails.root}/tmp/cache/rack")

      expect(cache_dir.entries).to include("body", "meta")
      subject.clear
      expect(cache_dir.entries).not_to include("body", "meta")
    end
  end

  describe "warm" do
    context "a collection of urls is supplied" do
      let(:urls_to_cache) {
                              [
                                "https://my_server/my_route/1/to_cache.json",
                                "https://my_server/my_route/1/to_cache.xml",
                                "https://my_server/my_route/2/to_cache.json"
                              ]
                          }
      it "requests the supplied urls" do
        urls_to_cache.each do |url|
          expect(subject).to receive(:`).with("curl #{url}")
        end
        subject.warm(urls_to_cache)
      end
    end

    context "nothing is supplied" do
      it "requests courses.json and courses.xml for each campus/term combination" do
        campus_abbreviations  = ["UMNCR", "UMNDL", "UMNMO", "UMNRO", "UMNTC"].take(rand(2..5))
        strms                 = ((Time.now.year-2000)..99).take(3).flat_map { |year| ["1#{year}3", "1#{year}5", "1#{year}9"] }

        allow(Campus).to receive(:all).and_return(campus_abbreviations.map { |abbr| Campus.new(abbreviation: abbr) } )
        allow(Term).to receive(:all).and_return(strms.map { |strm| Term.new(strm: strm) })

        campus_abbreviations.product(strms).each do |(abbr,strm)|
          expect(subject).to receive(:`).with("curl #{campus_term_courses_url(abbr, strm, format: :xml)}")
          expect(subject).to receive(:`).with("curl #{campus_term_courses_url(abbr, strm, format: :json)}")
        end
        subject.warm
      end
    end
  end

end