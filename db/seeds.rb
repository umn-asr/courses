# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Persisters::ActiveRecord::Campus.delete_all
Persisters::ActiveRecord::Term.delete_all
@campus_repo = Repositories::CampusRepository.new

%w(UMNTC UMNDL UMNMO UMNRC UMNRO).each do |abbreviation|
  campus = @campus_repo.build
  campus.abbreviation = abbreviation
  @campus_repo.save(campus)
end

%w(1155 1159 1163).each do |strm|
  repo = Repositories::TermRepository.new
  term = repo.build(attributes: {strm: strm})
  repo.save(term)
end
