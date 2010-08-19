Factory.define :live_stream_readio_one, :class => Stream do |u|
  u.name 'live'
  u.display_name  'Live Stream'
  u.association :service, :factory => :radio1
end