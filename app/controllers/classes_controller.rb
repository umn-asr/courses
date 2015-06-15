class ClassesController < ApplicationController
  def index
    expires_in(Rails.configuration.caching.default_expiry, :public => true)

    campus = Campus.fetch(params[:campus_id])
    term = Term.fetch(params[:term_id])

    if campus && term
      query_string_search = params[:q]
      courses_to_retrieve = QueryStringSearch.new(QueryableClasses.fetch(campus, term), query_string_search).results.collect(&:course)
      render_content(ClassesPresenter.fetch(campus, term, courses_to_retrieve).to_h)
    else
      render nothing: true, status: 404
    end
  end
end
