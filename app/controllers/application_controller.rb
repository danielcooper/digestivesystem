# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def fetch_service
    @service = Service.find_by_name(params[:service_id]) if params[:service_id]
  end

  def fetch_stream
    @stream = Stream.find(:first, :conditions => {:name => params[:stream_id], :service_id => @service.id}) if  params[:stream_id] && params[:service_id]
  end

  def fetch_resource
     @resource = Resource.find(params[:resource_id]) if params[:resource_id]
  end
end
