class TermsController < ApplicationController
  def index
    term_repo = Repositories::TermRepository.new
    @terms = term_repo.all()

    render
  end
end
