class ServicesController < ApplicationController


  def index
    @services = Service.all
  end
  
  def show
    @service = Service.find_by_name(params[:id])
    @service.exposures
  end
  
  def new
    @service = Service.new
  end
  
  def create
    @service = Service.new(params[:service])
    if @service.save
      flash[:notice] = "Successfully created service."
      redirect_to @service
    else
      render :action => 'new'
    end
  end
  
  def edit
    @service = Service.find_by_name(params[:id])
  end
  
  def update
    @service = Service.find_by_name(params[:id])
    if @service.update_attributes(params[:service])
      flash[:notice] = "Successfully updated service."
      redirect_to @service
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @service = Service.find_by_name(params[:id])
    @service.destroy
    flash[:notice] = "Successfully destroyed service."
    redirect_to services_url
  end
end
