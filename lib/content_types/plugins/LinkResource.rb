class ContentTypes::Plugins::LinkResource < ContentTypes::Base

  def initialize url
    @url = url
  end

  def self.plugin_name
    :linkresource
  end

  def self.model
    "LinkResource"
  end

  def self.can_handle_resource_type? url
    #URI.extract(url).length == 1
		false
  end

  def attributes
    @attributes ||= begin
			res = Net::HTTP.get(URI.parse(@url))
      doc = Hpricot.parse(res)
			desc = doc.at("//meta[@name='description']")
			blurb = desc["content"] if desc != nil
			#Hpricot seems to have issues with this, so regexing
			#imgsrc = doc.at("//link[@rel='image_src']")
			#image = imgsrc["href"] if imgsrc != nil
			img = /link rel="image_src" href="([^"]*)"/.match(res)[1].gsub!(/http:\/\/open\.live\.bbc\.co\.uk\/dynamic_images\/[^\/]*\/(.*)/, 'http://\1')
			{:resource_url => @url, :type => self.class.model, :title => doc.at("title").inner_html, :blurb => blurb, :external_image_url => img}
    end
  end



end