class Service < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :display_name


  validates_uniqueness_of :name

  has_many :streams

  
  def to_param
    name
  end
  
end
