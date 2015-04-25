require 'rails_helper'

RSpec.describe MeetingPatternPresenter do
  let(:meeting_pattern) { MeetingPattern.new }

  subject { described_class.new(meeting_pattern) }

  describe "start_date" do
    it "is the meeting pattern start_date formatted as yyyy-mm-dd" do
      start_date = Time.now
      meeting_pattern.start_date = start_date
      expect(subject.start_date).to eq(start_date.strftime('%Y-%m-%d'))
    end

    it "pads single month and date numbers with 0s" do
      meeting_pattern.start_date = Time.new(Time.now.year, 1, 1)
      expect(subject.start_date).to eq("#{Time.now.year}-01-01")
    end
  end

  describe "end_date" do
    it "is the meeting pattern end_date formatted as yyyy-mm-dd" do
      end_date = Time.now
      meeting_pattern.end_date = end_date
      expect(subject.end_date).to eq(end_date.strftime('%Y-%m-%d'))
    end

    it "pads single month and date numbers with 0s" do
      meeting_pattern.end_date = Time.new(Time.now.year, 1, 1)
      expect(subject.end_date).to eq("#{Time.now.year}-01-01")
    end
  end
end