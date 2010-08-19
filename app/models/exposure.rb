class Exposure < ActiveRecord::Base

  belongs_to :stream

  Resource.subclasses.each do |subclass|
    belongs_to subclass.name.underscore.gsub("b_b_c_", "bbc_").to_sym, :foreign_key => 'resource_id'
    accepts_nested_attributes_for subclass.name.underscore.gsub("b_b_c_", "bbc_").to_sym
  end
  
  belongs_to :resource
  accepts_nested_attributes_for :resource
  has_one :service, :through => :stream


  def to_json
    resource.to_json
  end

end
