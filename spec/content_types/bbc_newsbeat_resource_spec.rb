# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'
require "#{RAILS_ROOT}/lib/content_types/plugin_manager"

describe ContentTypes::Plugins::BBCNewsbeatResource do
  before(:each) do
    @newsbeat_resource = ContentTypes::Plugins::BBCNewsbeatResource
  end

  it "should match for twitter requests" do
    r = @newsbeat_resource.can_handle_resource_type?("http://www.bbc.co.uk/newsbeat/10995929")
    r.class.should_not == nil
    r.length.should == 1
    r[0].should == "http://www.bbc.co.uk/newsbeat/10995929"
  end

  it "should not match for broken twitter requests" do
    r = @newsbeat_resource.can_handle_resource_type?("http://www.NOTTHEBBC.co.uk/newsbeat/10995929")
    r.should == nil
    r.respond_to?(:length).should == false
  end

 it "should spit out pre-populate data" do
    r = @newsbeat_resource.new("http://www.bbc.co.uk/newsbeat/10995929")
    r.attributes[:title].include?("Sunbed lovers").should == true
 end

end

