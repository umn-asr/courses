class CoursesController < ApplicationController
  def index
    expires_in(Rails.configuration.caching.default_expiry, :public => true)

    campus = Campus.fetch(params[:campus_id])
    term = Term.fetch(params[:term_id])

    query_string_search = params[:q]
    courses_to_retrieve = QueryStringSearch.new(QueryableCourses.fetch(campus, term), query_string_search).results.collect(&:course)
    content = CoursesPresenter.fetch(campus, term, courses_to_retrieve)
    render params[:format].to_sym => Serializer.serialize(content, params[:format])
  end
end
