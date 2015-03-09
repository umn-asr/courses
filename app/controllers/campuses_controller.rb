class CampusesController < ApplicationController
  def index
    @campuses = Persisters::ActiveRecord::Campus.all

    render
  end
end
