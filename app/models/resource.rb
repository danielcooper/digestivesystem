class Resource < ActiveRecord::Base

  has_many :exposures



  def chosen_image
    if external_url_image
      return external_url_image
    end
    return nil
  end


  def resource_type= value_type
    self.type = value_type
  end


  def json_attributes
    [:title, :blurb, :external_image_url, :resource_url]
  end


  def to_json
    super(:only => json_attributes)
  end
  
end
