class ContentTypes::Plugins::BBCEpisodeResource < ContentTypes::Base

  def initialize url
    @url = url
    matches = self.class.can_handle_resource_type? url
    @twitter_status_id = matches[1]
  end

	def self.plugin_name
    :bbc_episode
  end

  def self.can_handle_resource_type? url
    /http:\/\/w{0,3}\.?bbc\.co\.uk\/programmes\/.*/
  end



end