class Exposure < ActiveRecord::Base
  belongs_to :stream
  belongs_to :resource
  accepts_nested_attributes_for :resource
  has_one :service, :through => :stream

  Resource.subclasses.each do |subclass|
    belongs_to subclass.name.underscore.to_sym, :foreign_key => 'resource_id'
    accepts_nested_attributes_for subclass.name.underscore.to_sym
  end
 
  validates_presence_of :stream_id

  def to_json
    resource.to_json
  end

	def admin_description
		"DEFINE ME"
	end

end
