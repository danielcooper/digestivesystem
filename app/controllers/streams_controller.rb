class StreamsController < ApplicationController
  before_filter :fetch_service

  def index
    @streams = @service.streams
  end
  
  def show
    @stream = Stream.find_by_name(params[:id])
  end
  
  def new
    @stream = Stream.new
  end
  
  def create
    @stream = Stream.new(params[:stream])
    if @stream.save
      flash[:notice] = "Successfully created streams."
      Pusher[@service.url_key].trigger('rumble', {:duration => 10})
      redirect_to [@service,@stream]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @streams = Stream.find_by_name(params[:id])
  end
  
  def update
    @stream = Stream.find_by_name(params[:id])
    @stream.service = @service
    if @stream.update_attributes(params[:streams])
      flash[:notice] = "Successfully updated streams."
      redirect_to [@service,@stream]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @stream = Stream.find_by_name(params[:id])
    @stream.destroy
    flash[:notice] = "Successfully destroyed streams."
    redirect_to service_streams_url(@stream)
  end



end