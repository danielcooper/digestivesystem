class ContentTypes::PluginManager < Array
	  include Singleton
	end

require 'singleton'
require File.expand_path(File.dirname(__FILE__) + '/base.rb')

Dir[File.dirname(__FILE__) + "/plugins/*.rb"].each{|file| require file}