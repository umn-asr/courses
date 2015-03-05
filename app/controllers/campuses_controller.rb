class CampusesController < ApplicationController
  def index
    campus_repo = Repositories::CampusRepository.new
    @campuses = campus_repo.all()

    render
  end
end
