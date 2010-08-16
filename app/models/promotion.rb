class Promotion < ActiveRecord::Base
  attr_accessible :type, :title, :blurb, :resource_url
end
