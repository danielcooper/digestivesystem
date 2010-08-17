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
      attributes = fetch_prefilled_attributes_for @provided_url
      @promotion = Promotion.new(attributes)
    end
  end
  
  def create
    @promotion = Promotion.new(params[:promotion])
    if @promotion.save
      flash[:notice] = "Successfully created promotion."
      redirect_to @promotion
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
        raise attributes.inspect
      end
    end
    return attributes
  end

  def load_plugins
    require "#{RAILS_ROOT}/lib/content_types/plugin_manager"
  end
end
