class ResourcesController < ApplicationController

  before_filter :load_plugins

  def index
    @resources = Resource.all
  end
  
  def show
    @resource = Resource.find(params[:id])
    @exposure = Exposure.new

    @service_list = Service.all.map {|n| [n, n.streams]}.to_json
  end
  
  def new
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
    @resource = params[:resource].delete(:type).constantize.new(params[:resource])
    if @resource.save
      flash[:notice] = "Successfully created resource."
      redirect_to resource_path(@resource)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @resource = Resource.find(params[:id])
  end
  
  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(params[:resource])
      flash[:notice] = "Successfully updated resource."
      redirect_to @resource
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    flash[:notice] = "Successfully destroyed resource."
    redirect_to resources_url
  end

  protected

  def load_plugins
    require "#{RAILS_ROOT}/lib/content_types/plugin_manager"
  end
end
