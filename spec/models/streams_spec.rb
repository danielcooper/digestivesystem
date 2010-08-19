require File.dirname(__FILE__) + '/../spec_helper'

describe Streams do
  it "should be valid" do
    Streams.new.should be_valid
  end
end
