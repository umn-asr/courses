class CampusesController < ApplicationController
  def index
    format = params.fetch(:format, 'json')
    content = {campuses: Campus.all.map { |x| x.to_h}}
    render format.to_sym => Serializer.serialize(content, format)
  end
end
