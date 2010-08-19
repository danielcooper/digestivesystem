require File.dirname(__FILE__) + '/../spec_helper'

describe Exposure do
  before do
    @stream = Factory.create(:live_stream_readio_one)
    @service = @stream.service
  end

  it "should be creatable with new track attributes" do
    build_info = {:bbc_track_resource_attributes => {:title => "test", :blurb => "quite"}}
    e = Exposure.create build_info
    puts e.resource.foo
    e.valid?.should == true
  end
end
