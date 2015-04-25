class CampusesController < ApplicationController
  def index
    render :json => Campus.all.map { |x| x.to_h}
  end
end
