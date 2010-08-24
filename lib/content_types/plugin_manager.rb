class ContentTypes::PluginManager < Array
  include Singleton
end

require 'singleton'
load File.expand_path(File.dirname(__FILE__) + '/base.rb')

Dir[File.dirname(__FILE__) + "/plugins/*.rb"].each{|file| load file}