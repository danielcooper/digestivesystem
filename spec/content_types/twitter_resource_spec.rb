# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'
require "#{RAILS_ROOT}/lib/content_types/plugin_manager"

describe ContentTypes::Plugins::TwitterResource do
  before(:each) do
    @twitter_resource = ContentTypes::Plugins::TwitterResource
  end

  it "should match for twitter requests" do
    r = @twitter_resource.can_handle_resource_type?("http://twitter.com/Saddleton/status/21321549812")
    r.class.should_not == nil
    r.length.should == 2
    r[1].should == "21321549812"
  end

  it "should not match for broken twitter requests" do
    r = @twitter_resource.can_handle_resource_type?("http://twibber.com/Saddleton/status/21321549812")
    r.should == nil
    r.respond_to?(:length).should == false
  end

 it "should spit out pre-populate data" do
    r = @twitter_resource.new("http://twitter.com/Saddleton/status/21321549812")
    r.attributes[:blurb].should == "@daniel_cooper and @halbpro are probably rocking the BBC's socks off right now."
 end

end

