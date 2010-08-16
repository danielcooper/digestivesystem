class ContentTypes::Plugins::TwitterResource < ContentTypes::Base

  def self.plugin_name
    :radio1_tweet
  end

  def self.can_handle_resource_type? url
    /http:\/\/twitter\.com\/[^\/]*\/status\/(\d*)/.match(url)
  end



end