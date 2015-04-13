class CoursesController < ApplicationController
  def index
    expires_in(48.hours, :public => true)

    @courses = CoursesPresenter.fetch(params[:campus_id], params[:term_id])

    query_string_search = params[:q]
    @courses.courses = QueryStringSearch.new(@courses.unfiltered_courses, query_string_search).results

    respond_to do |format|
      format.xml
      format.json
    end
  end
end
