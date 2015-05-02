class CoursesController < ApplicationController
  def index
    expires_in(48.hours, :public => true)

    campus = Campus.fetch(params[:campus_id])
    term = Term.fetch(params[:term_id])

    query_string_search = params[:q]
    courses_to_retrieve = QueryStringSearch.new(QueryableCourses.fetch(campus, term), query_string_search).results.collect(&:course)
    render_json_or_xml(CoursesPresenter.fetch(campus, term, courses_to_retrieve).to_h)
  end
end
