# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_exposure_preview exposure
    output = ""
    output << %~<img id ="small_image" src="#{exposure.image}" width = '74' height = '74'/>~
    if exposure.title
      output << exposure.title
    else
      output << "No Title"
    end
    output << " <small>#{exposure.blurb}</small>" if exposure.blurb
  end
end
