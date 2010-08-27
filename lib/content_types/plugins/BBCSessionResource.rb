class ContentTypes::Plugins::BBCSessionResource < ContentTypes::Base

  def initialize url
    @url = url    
  end

	def self.plugin_name
    :bbc_session_resource
  end

  def self.can_handle_resource_type? url
    /http:\/\/w{0,3}\.?bbc\.co\.uk\/radio1\/sessions\/(.*)/.match(url)
	end

	def self.model
		"BbcSessionResource"
	end

	def self.fetch_session_information_for url
    res = Net::HTTP.get(URI.parse("#{url}.json"))
    JSON.parse(res)
  end

  def attributes
    @attributes ||= begin
      @session_data ||= self.class.fetch_session_information_for(@url)
      {:resource_url => @url, :title => "#{@session_data["artist"]} - #{@session_data["date"]}", :artist_name => @session_data["artist"], :artist_gid => @session_data["artist_gid"], :blurb => @session_data["short_synopsis"], :type => self.class.model.to_s.camelize, :external_image_url => @session_data["image"]}
    end
  end

end