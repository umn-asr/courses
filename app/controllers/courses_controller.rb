class CoursesController < ApplicationController
  def index
    expires_in(48.hours, :public => true)

    campus = Campus.fetch(params[:campus_id])
    term = Term.fetch(params[:term_id])

    query_string_search = params[:q]
    courses_to_retrieve = QueryStringSearch.new(QueryableCourses.fetch(campus, term), query_string_search).results.collect(&:course)
    content = CoursesPresenter.fetch(campus, term, courses_to_retrieve)

    respond_to do |format|
      format.xml { render xml: Serializer.serialize(content, 'xml') }
      format.json { render json: Serializer.serialize(content, 'json') }
      format.any  { render nothing: true, status: 404 }
    end
  end
end
