class CoursesController < ApplicationController
  def index
    expires_in(48.hours, :public => true)

    campus = Campus.fetch(params[:campus_id])
    term = Term.fetch(params[:term_id])

    query_string_search = params[:q]
    courses_to_display = QueryStringSearch.new(QueryableCourses.fetch(campus, term), query_string_search).results

    courses_to_retrieve = courses_to_display.collect(&:course)

    @courses = CoursesPresenter.fetch(campus, term, courses_to_retrieve)

    respond_to do |format|
      format.xml
      format.json
    end
  end
end
