class ContentTypes::Base
  require 'net/http'
  require 'uri'
  require 'json/add/rails'

  def self.inherited(klass)
    ContentTypes::PluginManager.instance << klass
  end

  def can_handle_resource_type? url
    raise "Can handle not defined: #{self.class.name}"
  end

  def plugin_name
    raise "Plugin without name: #{self}"
  end

end