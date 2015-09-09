class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  #
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "GET"
    headers["Access-Control-Max-Age"] = "1728000"
  end

  def cors_preflight_check
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "GET"
    headers["Access-Control-Max-Age"] = "1728000"
  end

  private


  def render_content(content)
    respond_to do |format|
      format.xml { render xml: Serializer.serialize(content, 'xml') }
      format.json { render json: Serializer.serialize(content, 'json') }
      format.any  { render nothing: true, status: 404 }
    end
  end
end
