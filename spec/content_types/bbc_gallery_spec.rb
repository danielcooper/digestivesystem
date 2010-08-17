# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'
require "#{RAILS_ROOT}/lib/content_types/plugin_manager"

describe ContentTypes::Plugins::BBCGalleryResource do
  before(:each) do
    @bbc_gallery_resource = ContentTypes::Plugins::BBCGalleryResource
  end

  it "should match for radio 1 gallery requests" do
    r = @bbc_gallery_resource.can_handle_resource_type?("http://www.bbc.co.uk/radio1/photos/gregjames/5551/24#gallery5551")
    r.class.should_not == nil
		r.length.should == 5
    r[0].should == "http://www.bbc.co.uk/radio1/photos/gregjames/5551/24"
  end

  it "should not match for broken r1 gallery requests" do
    r = @bbc_gallery_resource.can_handle_resource_type?("http://www.cbbc.co.uk/radio1/photos/gregjames/5551/24#gallery5551")
    r.should == nil
    r.respond_to?(:length).should == false
  end

 it "should spit out pre-populate data" do
    r = @bbc_gallery_resource.new("http://www.bbc.co.uk/radio1/photos/gregjames/5551/24#gallery5551")
    r.attributes[:blurb].should == "Check out who Greg has been spending quality time with...."
		r.attributes[:type].should == r.class.model.to_s.camelize
 end

end