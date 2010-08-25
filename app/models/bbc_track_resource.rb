class BbcTrackResource < Resource

  def json_attributes
    super + [:artist_name]
  end

end