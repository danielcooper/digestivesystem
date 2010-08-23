class Service < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :display_name


  validates_uniqueness_of :name

  has_many :streams
	has_many :exposures, :through => :streams

  
  def to_param
    name
  end


  def logo
    "/images/#{name}_logo.png"
  end
  
end
