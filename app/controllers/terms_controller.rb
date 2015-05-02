class TermsController < ApplicationController
  def index
    expires_in(48.hours, :public => true)
    render_json_or_xml({terms: Term.all.map(&:to_h)})
  end
end
