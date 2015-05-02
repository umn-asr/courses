class TermsController < ApplicationController
  def index
    expires_in(48.hours, :public => true)
    render_content({terms: Term.all.map(&:to_h)})
  end
end
