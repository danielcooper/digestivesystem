class ExposuresController < ApplicationController
  before_filter :fetch_service
  before_filter :fetch_stream
  before_filter :fetch_resource
  
  def index
    @exposures = @resource.exposures.sort_by { |exposure| -exposure.created_at.to_i } if @resource
    @exposures = @stream.exposures.sort_by { |exposure| -exposure.created_at.to_i }  if @stream
    respond_to do |format|
      format.html
      format.json{
        render :json => "{\"exposures\":#{@exposures.map{|e| e.to_json }.to_json}}"

      }
    end
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
    Resource.subclasses.map { |subclass| subclass.name.underscore }.each do |type|
      if params[:exposure][params["#{type}_attributes".to_sym]]
        @resource = type.camelcase.constantize.new(params[:exposure][params["#{type}_attributes".to_sym]])
        dup = resource.is_duplicate?
        @resource = dup if dup
        params[:exposure] = params[:exposure].delete_if{|k,v| k == ("#{type}_attributes".to_sym)}
      end
    end

    @exposure = Exposure.new(params[:exposure])
    @exposure.resource = @resource
    @exposure.stream = @stream
    if @exposure.save
      Pusher["#{@service.name}-#{@stream.name}"].trigger("added_exposure", @exposure.to_json)
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
