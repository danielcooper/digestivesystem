# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def fetch_service
    @service = Service.find_by_name(params[:service_id])
  end

  def fetch_stream
    @stream = Stream.find_by_name(params[:stream_id])
  end

  def fetch_resource
     @resource = Resource.find_by_name(params[:stream_id])
  end
end
