class SubjectsController < ApplicationController
  def index
    expires_in(Rails.configuration.caching.default_expiry, :public => true)

    campus = Campus.fetch(params[:campus_id])
    term = Term.fetch(params[:term_id])
    subjects = Subject.where(campus: campus, term: term)

    render_content({subjects: subjects.all.map(&:to_h)})
  end
end
