class Stream < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :display_name

  validates_uniqueness_of :name, :scope => :service_id

  belongs_to :service
  has_many :exposures


  def to_param
    name
  end
  
end
