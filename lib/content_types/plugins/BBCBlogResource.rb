class ContentTypes::Plugins::BBCGalleryResource < ContentTypes::Base
  require 'simple-rss'
  require 'open-uri'
  SimpleRSS.feed_tags << :summary

  #http:\/\/w{0,3}\.?bbc.co.uk\/blogs\/(([a-z]*)\/\d{4}\/\d{2}\/(\S*)).html ->
  #chrismoyles/2010/08/were_back_3
  #chrismoyles
  #were_back_3
  def self.can_handle_resource_type? url
    /http:\/\/www.bbc.co.uk\/blogs\/(([a-z]*)\/\d{4}\/\d{2}\/(\S*)).html/.match(url)
  end

  def initialize url
    @url = url
    matches = self.class.can_handle_resource_type? url
    @blog_url_full = matches[0]
    @blog_url = matches[1]
    @blog_name = matches[2]
    @post_name = matches[3]
  end

  def self.plugin_name
    :bbc_blog_post
  end

  def self.model
    :bbc_blog_post_promotion
  end

  def attributes
    @attributes ||= begin
      rss = SimpleRSS.parse open("http://bbc.co.uk/blogs/#{@blog_name}/rss.xml")
      blog_attributes = nil

      rss.items.each do |n|
        if n.link.include? @blog_url
          blog_attributes = {:resource_url => n.link, :title => n.title, :blurb => n.description.gsub(%r{</?[^>]+?>}, ''), :type => self.class.model.to_s.camelize}
          break
        end
      end

      raise "Could not fetch infomation from this webpage" if blog_attributes == nil
      blog_attributes
    end
  end
end