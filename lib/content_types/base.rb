class ContentTypes::Base
  def self.inherited(klass)
    ContentTypes::PluginManager.instance << klass
  end

  def initialize args
    @options = args
  end

  def can_handle_resource_type? url
    raise "Can handle not defined: #{self.class.name}"
  end

  def method_missing(method, *args)
    if @options.has_key? method
      return @options[method]
    else
      super
    end
  end

  def plugin_name
    raise "Plugin without name: #{self}"
  end

end