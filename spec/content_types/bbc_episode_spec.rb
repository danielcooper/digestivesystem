# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'
require "#{RAILS_ROOT}/lib/content_types/plugin_manager"

describe ContentTypes::Plugins::BBCEpisodeResource do
  before(:each) do
    @bbc_episode_resource = ContentTypes::Plugins::BBCEpisodeResource
  end

  it "should match for bbc episode requests" do
    r = @bbc_episode_resource.can_handle_resource_type?("http://www.bbc.co.uk/programmes/b00tdmhg")
    r.class.should_not == nil
    r.length.should == 1
    r[0].should == "http://www.bbc.co.uk/programmes/b00tdmhg"
  end

  it "should not match for broken episode requests" do
    r = @bbc_episode_resource.can_handle_resource_type?("http://www.cbbc.co.uk/programmes/b00tdmhg")
    r.should == nil
    r.respond_to?(:length).should == false
  end

 it "should spit out pre-populate data" do
    r = @bbc_episode_resource.new("http://www.bbc.co.uk/programmes/b00tdmhg")
    r.attributes[:blurb].should == "Sara Cox sits in for Fearne Cotton with the home of BBC Radio 1's Live Lounge."
		r.attributes[:type].should == r.class.model.to_s.camelize
 end

end

