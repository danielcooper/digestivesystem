class Resource < ActiveRecord::Base

  has_many :exposures


  def self.subclasses
    super
  end

  def chosen_image
    if external_url_image
      return external_url_image
    end
    return nil
  end

  def resource_type= value_type
    self.type = value_type
  end


  def json_attributes
    [:resource_url, :type]
  end


  def export_hash
    attributes.delete_if{|key,value| json_attributes.include?(key.to_sym) != true}
  end


  def is_duplicate?
    Resource.find(:first, :conditions => {:resource_url => self.resource_url})
  end
  
  def to_json
    super(:only => json_attributes)
  end


  def self.fetch_prefilled_attributes_for url
    attributes = {}
    ContentTypes::PluginManager.instance.each do |n|
      if n.can_handle_resource_type?(url)
        attributes = n.new(url).attributes
      end
    end
		attributes = ContentTypes::Plugins::LinkResource.new(url).attributes if attributes.empty? && URI.extract(url).length > 0
    return attributes
  end
  
end
