class CoursesController < ApplicationController
  def index
    expires_in(48.hours, :public => true)

    @courses = CoursesPresenter.fetch(params[:campus_id], params[:term_id])
    campus = Campus.fetch(params[:campus_id])
    term = Term.fetch(params[:term_id])

    query_string_search = params[:q]
    filtered_courses = QueryStringSearch.new(@courses.queryable_courses, query_string_search).results

    @courses.courses = CoursesPresenter.retrieve(filtered_courses)

    respond_to do |format|
      format.xml
      format.json
    end
  end
end
