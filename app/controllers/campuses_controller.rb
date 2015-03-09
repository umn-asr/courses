class CampusesController < ApplicationController
  def index
    @campuses = Campus.all

    render
  end
end
