class PromotionsController < ApplicationController
  before_filter :fetch_service
  before_filter :fetch_stream
  before_filter :fetch_resource
  
  def index
    @promotions = @service.exposures.sort_by {|exposure| -exposure.birth.to_i}  if @service

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
    streams = @service.streams
    stream_types = streams.map {|n| n.name}

    resource = params[:promotion].delete(:type).constantize.create(params[:promotion]) #save resource (todo: save or load)

    if params[:selected_exposures]
      params[:selected_exposures].each do |key,value|
        if stream_types.include? key
          exposure_attributes = params[:selected_exposures][key].merge(params[:exposures_template]).delete_if {|k, v| k == "active" }
          stream = streams.select{|n| n.name == key}.first
          exposure_attributes[:stream_id] = stream.id
          exposure_attributes[:resource_id] = resource.id
          exposure = Exposure.create exposure_attributes
          Pusher["#{@service.name}-#{stream.name}"].trigger("added_exposure", exposure.to_json)
        end
      end
      
      flash[:notice] = "Successfully created exposure."
      redirect_to [@service,@stream,@exposure]
      
    end
  end
  
end

