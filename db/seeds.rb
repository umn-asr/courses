# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Campus.delete_all
Term.delete_all
Course.delete_all
Subject.delete_all
CourseAttribute.delete_all
Section.delete_all
InstructionMode.delete_all
GradingBasis.delete_all
InstructorContact.delete_all
InstructorRole.delete_all
Instructor.delete_all
Day.delete_all
Location.delete_all
MeetingPattern.delete_all
CombinedSection.delete_all
Equivalency.delete_all

%w(UMNTC UMNDL UMNMO UMNCR UMNRO).each do |abbreviation|
  Campus.create({abbreviation: abbreviation})
end

%w(1149 1155 1159 1163).each do |strm|
  Term.create({strm: strm})
end

{"m" => "Monday", "t" => "Tuesday", "w" => "Wednesday", "th" => "Thursday", "f" => "Friday", "sa" => "Saturday", "su" => "Sunday"}.each do |abbreviation, name|
  Day.create(abbreviation: abbreviation, name: name)
end

%w(1149 1155 1159 1163).each do |strm|
  Term.create({strm: strm})
end

f = File.open('test/fixtures/courses_example.json')
j = JSON.parse(f.read)
f.close
JsonImport.new(j).run
