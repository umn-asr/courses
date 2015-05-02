class CampusesController < ApplicationController
  def index
    expires_in(48.hours, :public => true)
    render_json_or_xml({campuses: Campus.all.map(&:to_h)})
  end
end
