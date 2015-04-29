class CampusesController < ApplicationController
  def index
    content = {campuses: Campus.all.map { |x| x.to_h}}

    respond_to do |format|
      format.xml { render xml: Serializer.serialize(content, 'xml') }
      format.json { render json: Serializer.serialize(content, 'json') }
      format.any  { render nothing: true, status: 404 }
    end
  end
end
