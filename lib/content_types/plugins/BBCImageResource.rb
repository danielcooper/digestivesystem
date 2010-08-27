class ContentTypes::Plugins::BBCImageResource < ContentTypes::Base

  def initialize url
    @url = url
  end

  def self.plugin_name
    :image_resource
  end

  def self.model
    "BbcImageResource"
  end

  def self.can_handle_resource_type? url
    /https?:\/\/.*.(jpg|png|jpeg|gif|bmp|tiff)/.match(url)
  end

  def attributes
    @attributes ||= begin
      {:resource_url => @url, :type => self.class.model, :external_image_url => @url}
    end
  end



end