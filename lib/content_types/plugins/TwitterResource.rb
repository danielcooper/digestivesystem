
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
    "TwitterResource"
  end

  def self.can_handle_resource_type? url
    /https?:\/\/w{0,3}\.?twitter\.com\/[^\/]*\/status\/(\d*)/.match(url)
  end


  def fetch_twitter_infomation_for id
    res = Net::HTTP.get(URI.parse("http://api.twitter.com/1/statuses/show/#{id}.json"))
    @twitter_data = JSON.parse(res)
  end

  def attributes
    @attributes ||= begin
      @twitter_data ||= fetch_twitter_infomation_for(@twitter_status_id)
      {:resource_url => @url, :title => "@#{@twitter_data["user"]["name"]}", :blurb => @twitter_data["text"], :type => self.class.model.to_s.camelize, :external_image_url => @twitter_data["user"]["profile_image_url"].gsub!(/_normal/, '')}
    end
  end
end
