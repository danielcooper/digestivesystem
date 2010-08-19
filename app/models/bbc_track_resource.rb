class BbcTrackResource < Resource

  def foo
    "bar"
  end

  def json_attributes
    super + [:artist_name]
  end

end