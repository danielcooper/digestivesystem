<<<<<<< HEAD
class ContentTypes::Plugins::BBCGalleryResource < ContentTypes::Base

	# Match 1 = Route URL of Galleries (i.e. /radio1/photos)
	# Match 2 = Brand Name
	# Match 3 = Gallery ID
	# Match 4 = Photo Number
  def self.can_handle_resource_type? url
    /(http:\/\/w{0,3}\.?bbc\.co\.uk\/radio1\/photos\/)([^\/]*)\/(\d+)\/?(\d*)/.match(url)
  end

  def initialize url
    @url = url
    matches = self.class.can_handle_resource_type? url
    @gallery_url_full = matches[0]
		@gallery_base = matches[1]
    @gallery_brand = matches[2]
    @gallery_id = matches[3]
    @gallery_position = matches.length > 3 ? matches[4] : nil
  end

  def self.plugin_name
    :bbc_gallery
  end

  def self.model
    "BBCGalleryPromotion"
  end


	def fetch_gallery_information
		res = Net::HTTP.get(URI.parse("#{@gallery_base}#{@gallery_brand}/#{@gallery_id}.json"))
    res.gsub!(/,[^}"\]]*\}/, "}")
		res.gsub!(/\},[^\]\{]*\]/, "} ]")
		@gallery_data = JSON.parse(res)
		@gallery_images = @gallery_data["gallery"]["photos"].length == 1  ? @gallery_data["gallery"]["photos"][1]["image_square"] : @gallery_data["gallery"]["photos"].map{ |photo| photo["image_square"]}
		@gallery_data
	end

  def attributes
    @attributes ||= begin
      @gallery_data ||= fetch_gallery_information
      {:resource_url => @url, :title => @gallery_data["gallery"]["title"], :blurb => @gallery_data["gallery"]["description"], :type => self.class.model.to_s.camelize, :external_image_url => @gallery_images}
    end
  end

end