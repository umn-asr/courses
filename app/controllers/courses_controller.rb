class CoursesController < ApplicationController
  def index
    campus = Campus.where(abbreviation: params[:campus_id].upcase).first
    term = Term.where(strm: params[:term_id]).first

    courses = Course.where(campus_id: campus.id, term_id: term.id)

    searchable_courses = SearchableCourses.new(courses)

    query_string_search = params[:q]
    returned_courses = QueryStringSearch.new(searchable_courses, query_string_search).results

    @courses = CoursesPresenter.new
    @courses.campus = campus
    @courses.term = term
    @courses.courses = returned_courses

    respond_to do |format|
      format.xml
      format.json
    end
  end
end
