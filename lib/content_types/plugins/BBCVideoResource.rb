class ContentTypes::Plugins::BBCVideoResource < ContentTypes::Base

  def initialize url
    @url = url
		matches = self.class.can_handle_resource_type? url
    @pid = matches[1]
  end

	def self.plugin_name
    :bbc_episode
  end

  def self.can_handle_resource_type? url
    if (match = /http:\/\/w{0,3}\.?bbc\.co\.uk\/programmes\/(.*)/.match(url)) && self.fetch_episode_information_for(url)["programme"]["type"] == "clip"
			match
		else
			nil
		end
	end

	def self.model
		"BBCVideoPromotion"
	end

	def self.fetch_episode_information_for url
    res = Net::HTTP.get(URI.parse("#{url}.json"))
    JSON.parse(res)
  end

  def attributes
    @attributes ||= begin
      @episode_data ||= self.class.fetch_episode_information_for(@url)
      {:resource_url => @url, :title => @episode_data["programme"]["title"], :blurb => @episode_data["programme"]["short_synopsis"], :type => self.class.model.to_s.camelize, :external_url_image =>"http://www.bbc.co.uk/iplayer/images/clip/#{@pid}_150_84.jpg", :pid => @pid}
    end
  end
end