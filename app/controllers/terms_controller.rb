class TermsController < ApplicationController
  def index
    render :json => Term.all.map { |x| x.to_h}
  end
end
