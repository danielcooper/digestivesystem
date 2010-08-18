# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'
require "#{RAILS_ROOT}/lib/content_types/plugin_manager"

describe ContentTypes::Plugins::BBCVideoResource do
  before(:each) do
    @bbc_video_resource = ContentTypes::Plugins::BBCVideoResource
  end

  it "should match for bbc episode requests" do
    r = @bbc_video_resource.can_handle_resource_type?("http://www.bbc.co.uk/programmes/p009gb0z")
    r.class.should_not == nil
		puts r.class
    r.length.should == 2
    r[0].should == "http://www.bbc.co.uk/programmes/p009gb0z"
  end

  it "should not match for broken episode requests" do
    r = @bbc_video_resource.can_handle_resource_type?("http://www.cbbc.co.uk/programmes/b00tdmhg")
    r.should == nil
    r.respond_to?(:length).should == false
  end

 it "should spit out pre-populate data" do
    r = @bbc_video_resource.new("http://www.bbc.co.uk/programmes/p009gb0z")
    r.attributes[:blurb].should == "Roll Deep perform 'Green Light' in the live lounge for Sara"
		r.attributes[:type].should == r.class.model.to_s.camelize
 end

end

