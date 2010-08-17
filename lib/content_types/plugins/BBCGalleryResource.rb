class ContentTypes::Plugins::BBCGalleryResource < ContentTypes::Base

	# Match 1 = Route URL of Galleries (i.e. /radio1/photos)
	# Match 2 = Brand Name
	# Match 3 = Gallery ID
	# Match 4 = Photo Number
  def self.can_handle_resource_type? url
    /(http:\/\/w{0,3}\.?bbc\.co\.uk\/radio1\/photos\/([^\/]*)\/(\d+))\/(\d*)/.match(url)
  end

  def initialize url
    @url = url
    matches = self.class.can_handle_resource_type? url
    @gallery_url_full = matches[0]
		@gallery_base = matches[1]
    @gallery_brand = matches[2]
    @gallery_id = matches[3]
    @gallery_position = matches[4]
  end

  def self.plugin_name
    :bbc_gallery
  end

  def self.model
    :bbc_gallery_promotion
  end


	def fetch_gallery_information
		puts "#{@gallery_base}#{@gallery_brand}/#{@gallery_id}.json"
		res = Net::HTTP.get(URI.parse("#{@gallery_base}#{@gallery_brand}/#{@gallery_id}.json"))
    @gallery_data = JSON.parse(res)
		puts @gallery_data.inspect
	end

  def attributes
    @attributes ||= begin
      @gallery_data ||= fetch_gallery_information
      {:resource_url => @url, :title => @gallery_data["gallery"]["title"], :blurb => @episode_data["gallery"]["description"], :type => self.class.model.to_s.camelize}
    end
  end

end