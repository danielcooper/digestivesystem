class PromotionsController < ApplicationController

  before_filter :load_plugins

  def index
    @promotions = Promotion.all
  end
  
  def show
    @promotion = Promotion.find(params[:id])
  end
  
  def new
    if params[:url]
      @provided_url = params[:url]
      attributes = fetch_prefilled_attributes_for @provided_url rescue ""
      unless attributes.empty?
        @promotion = attributes[:type].constantize.new(attributes)
      else
        flash[:notice] = "We couldn't get any infomation from that url!"
        @promotion = Promotion.new
      end
    else
      flash[:notice] = "No URL specified."
      @promotion = Promotion.new
    end
  end
  
  def create
    @promotion = params[:promotion][:type].constantize.new(params[:promotion])
    if @promotion.save
      flash[:notice] = "Successfully created promotion."
      redirect_to promotion_path(@promotion)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @promotion = Promotion.find(params[:id])
  end
  
  def update
    @promotion = Promotion.find(params[:id])
    if @promotion.update_attributes(params[:promotion])
      flash[:notice] = "Successfully updated promotion."
      redirect_to @promotion
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @promotion = Promotion.find(params[:id])
    @promotion.destroy
    flash[:notice] = "Successfully destroyed promotion."
    redirect_to promotions_url
  end

  protected

  def fetch_prefilled_attributes_for url
    attributes = {}
    ContentTypes::PluginManager.instance.each do |n|
      if n.can_handle_resource_type?(url)
        attributes = n.new(url).attributes
      end
    end
    return attributes
  end

  def load_plugins
    require "#{RAILS_ROOT}/lib/content_types/plugin_manager"
  end
end
