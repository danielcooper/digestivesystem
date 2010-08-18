class Promotion < ActiveRecord::Base

  def chosen_image
    if external_url_image
      return external_url_image
    end
    return nil
  end
  
end
