class ExposuresController < ApplicationController
  before_filter :fetch_service
  before_filter :fetch_stream
  before_filter :fetch_resource
  
  def index
    @exposures = @resource.exposures if @resource
    @exposures = @stream.exposures if @stream
  end
  
  def show
    @exposure = Exposure.find(params[:id], :include=> [:resource], :order => "created_at DESC")
    respond_to do |format|
      format.html
      format.json{
        render :json => @exposure.to_json
      }
    end
  end
  
  def new
    @exposure = Exposure.new
    if params[:url]
      @provided_url = params[:url]
      attributes = Resource.fetch_prefilled_attributes_for @provided_url
      unless attributes.empty?
        @resource = attributes[:type].constantize.new(attributes)
      else
        flash[:notice] = "We couldn't get any infomation from that url!"
        @resource = Resource.new
      end
    else
      flash[:notice] = "No URL specified."
      @resource = Resource.new
    end
  end
  
  def create
    @exposure = Exposure.new(params[:exposure])
    @exposure.stream = @stream
    if @exposure.save
      Pusher[@service.name].trigger('rumble', {:duration => 10})
      flash[:notice] = "Successfully created exposure."
      redirect_to [@service,@stream,@exposure]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @exposure = Exposure.find(params[:id])
  end
  
  def update
    @exposure = Exposure.find(params[:id])
    if @exposure.update_attributes(params[:exposure])
      flash[:notice] = "Successfully updated exposure."
      redirect_to @exposure
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @exposure = Exposure.find(params[:id])
    @exposure.destroy
    flash[:notice] = "Successfully destroyed exposure."
    redirect_to exposures_url
  end
end
