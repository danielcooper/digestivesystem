class BbcTrackResource < Resource

  def json_attributes
    super + [:artist_name, :artist_gid]
  end

  def is_duplicate?
    Resource.find(:first, :conditions => {:artist_name => artist_name, :title => title})
  end

end