class ContentTypes::Plugins::BBCEpisodeResource < ContentTypes::Base

  def initialize url
    @url = url    
  end

	def self.plugin_name
    :bbc_episode
  end

  def self.can_handle_resource_type? url
    /http:\/\/w{0,3}\.?bbc\.co\.uk\/programmes\/.*/.match(url)
  end

	def self.model
		 "BbcEpisodeResource"
	end

	def fetch_episode_information
    res = Net::HTTP.get(URI.parse("#{@url}.json"))
    @episode_data = JSON.parse(res)
  end

  def attributes
    @attributes ||= begin
      @episode_data ||= fetch_episode_information
      {:resource_url => @url, :title => @episode_data["programme"]["title"], :blurb => @episode_data["programme"]["short_synopsis"], :type => self.class.model.to_s.camelize}
    end
  end
end