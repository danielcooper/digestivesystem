class BbcSessionResource < Resource

  def json_attributes
    super + [:artist_name, :artist_gid]
  end

  
end