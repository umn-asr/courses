class TermsController < ApplicationController
  def index
    @terms = Persisters::ActiveRecord::Term.all

    render
  end
end
