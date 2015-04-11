class CoursesController < ApplicationController
  def index
    expires_in(48.hours, :public => true)

    campus = Campus.where(abbreviation: params[:campus_id].upcase).first
    term = Term.where(strm: params[:term_id]).first

    searchable_courses = SearchableCourses.find(campus, term)

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
