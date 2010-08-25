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

  def json_attributes
    [:blurb,:title,:image,:name]
  end

  def to_json
    resource.export_hash.merge(attributes.delete_if{|key,value| json_attributes.include?(key.to_sym) != true})
  end

  def admin_description
    "TODO:IMPLEMENT ME!"
  end

  def after_create
    attributes["blurb"] = resource.blurb if attributes["blurb"].blank?
    attributes["image"] = resource.exturnal_image_url if attributes["image"].blank?
    attributes["title"] = resource.title if attributes["title"].blank?
    self.save
  end

end
