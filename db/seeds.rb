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

%w(UMNTC UMNDL UMNMO UMNRC UMNRO).each do |abbreviation|
  Campus.create({abbreviation: abbreviation})
end

%w(1149 1155 1159 1163).each do |strm|
  Term.create({strm: strm})
end

f = File.open('test/fixtures/courses_example.json')

j = JSON.parse(f.read)

j["courses"].each do |course|
  course_attr = Hash.new
  course_attr = course.slice("title", "description", "course_id", "catalog_number")

  campus = Campus.where(abbreviation: j["campus"]["abbreviation"]).first
  course_attr[:campus_id] = campus.id

  term = Term.where(strm: j["term"]["strm"]).first
  course_attr[:term_id] = term.id

  Subject.create(course["subject"].slice("subject_id", "description"))

  c = Course.create(course_attr)
  c.subjects = Subject.where(subject_id: course["subject"]["subject_id"])
  c.save
end

