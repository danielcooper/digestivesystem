class ContentTypes::Plugins::TwitterResource < ContentTypes::Base

  def initialize url
    @url = url
    matches = self.class.can_handle_resource_type? url
    @twitter_status_id = matches[1]
  end

  def self.plugin_name
    :radio1_tweet
  end

  def self.model
    :twitter_promotion
  end

  def self.can_handle_resource_type? url
    /http:\/\/twitter\.com\/[^\/]*\/status\/(\d*)/.match(url)
  end


  def fetch_twitter_infomation_for id
    res = Net::HTTP.get(URI.parse("http://api.twitter.com/1/statuses/show/#{id}.json"))
    @twitter_data = JSON.parse(res)
  end

  def attributes
    @attributes ||= begin
      @twitter_data ||= fetch_twitter_infomation_for(@twitter_status_id)
      {:resource_url => @url, :title => @twitter_data["text"], :blurb => @twitter_data["text"], :type => "TweetPromotion"}
    end
  end



end