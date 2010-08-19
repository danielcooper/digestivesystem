require File.dirname(__FILE__) + '/../spec_helper'
 
describe ExposuresController do
  fixtures :all
  integrate_views

  before do
    @stream = Factory.create(:live_stream_readio_one)
    @service = @stream.service
  end
  
  it "index action should create exposures and a resource if a new resource is given" do
    
    count_exposures = Exposure.count
    count_resources = Resource.count
    
    build_info = {:bbc_track_resource_attributes => {:title => "test_title", :blurb => "blurb", :artist_name => "artist", :artist_gid => "gid" }}
    post :create, :service_id => @service.to_param, :stream_id => @stream.to_param, :exposure => build_info

    count_exposures.should < Exposure.count
    count_resources.should < Resource.count

  end

  it "should give a list of current exposures in json" do
    build_info = {:bbc_track_resource_attributes => {:title => "test_title", :blurb => "blurb", :artist_name => "artist", :artist_gid => "gid" }}
    post :create, :service_id => @service.to_param, :stream_id => @stream.to_param, :exposure => build_info

    e = Exposure.last
    get :show, :id => e, :service_id => @service.to_param, :stream_id => @stream.to_param, :format => "json"
    puts response.body.inspect
  end
  
end
