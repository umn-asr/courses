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

%w(UMNTC UMNDL UMNMO UMNRC UMNRO).each do |abbreviation|
  Campus.create({abbreviation: abbreviation})
end

%w(1149 1155 1159 1163).each do |strm|
  Term.create({strm: strm})
end
