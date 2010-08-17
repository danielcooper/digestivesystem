class ContentTypes::Plugins::BBCNewsbeatResource < ContentTypes::Base

  def initialize url
    @url = url
  end

  def self.plugin_name
    :newsbeat
  end

  def self.model
    "BBCNewsbeatPromotion"
  end

  def self.can_handle_resource_type? url
    /http:\/\/w{0,3}\.?bbc.co.uk\/newsbeat\/\d+/.match(url)
  end

  def attributes
    @attributes ||= begin
      res = Net::HTTP.get(URI.parse(@url))
      doc = Hpricot.parse(res)

      output = {:resource_url => @url, :type => self.class.model}

      targeted_tags = [["Headline",:title],["Description",:blurb]]
      doc.search("//meta").each do |meta_tag|
        targeted_tags.each do |target|
            output[target.last] = meta_tag.attributes["content"] if target.first == meta_tag.attributes["name"]
        end
      end
      output
    end
  end



end