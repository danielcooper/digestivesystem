# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'
require "#{RAILS_ROOT}/lib/content_types/plugin_manager"

describe ContentTypes::Plugins::LinkResource do
  before(:each) do
    @link_resource = ContentTypes::Plugins::LinkResource
  end

  it "should match for all link requests" do
    r = @link_resource.can_handle_resource_type?("http://www.bbc.co.uk")
    r.class.should === false
  end

 it "should spit out pre-populate data" do
    r = @link_resource.new("http://www.bbc.co.uk/radio1/sessions/2010-08-17_rolldeep")
    r.attributes[:title] == "BBC - Radio 1 - Live Lounge - Roll Deep"
		r.attributes[:blurb].should == "The Good Times stars get the Green Light in the Live Lounge"
		r.attributes[:type].should == r.class.model.to_s.camelize
		r.attributes[:external_image_url].should == "http://open.live.bbc.co.uk/dynamic_images/radio1_146x82/www.bbc.co.uk/radio1/sessions/images/sessions/2010-08-17_rolldeep.jpg"
 end
end