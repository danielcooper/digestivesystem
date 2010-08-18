# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'
require "#{RAILS_ROOT}/lib/content_types/plugin_manager"

describe ContentTypes::Plugins::BBCBlogResource do
  before(:each) do
    @blog_resource = ContentTypes::Plugins::BBCBlogResource
  end

  it "should match for twitter requests" do
    r = @blog_resource.can_handle_resource_type?("http://www.bbc.co.uk/blogs/chrismoyles/2010/08/were_back_3.html")
    r.class.should_not == nil
    r.length.should == 4
    r[1].should == "chrismoyles/2010/08/were_back_3"
  end

  it "should not match for broken twitter requests" do
    r = @blog_resource.can_handle_resource_type?("http://www.NOTTHEBBC.co.uk/blogs/chrismoyles/2010/08/were_back_3.html")
    r.should == nil
    r.respond_to?(:length).should == false
  end

 it "should spit out pre-populate data" do
    r = @blog_resource.new("http://www.bbc.co.uk/blogs/chrismoyles/2010/08/were_back_3.html")
    puts r.attributes.inspect
    r.attributes[:blurb].include?("Chris - has to sit through a boring presentation").should == true
 end

end

