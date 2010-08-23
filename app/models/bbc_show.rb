class BbcShow
	require 'net/http'
	require 'json'
	require 'ostruct'

	attr_accessor :info

	
	#Service should be the key as provided by BBC JSON
	def initialize info
		@info = info
	end

	def	self.find_by_time time, service
		get_schedule(time, service).map{|show| return new(show) if Time.parse(show["start"]) < time && Time.parse(show["end"]) > time }
	end

	def self.find_by_pid pid, date = Date.today, service = parse_json("http://www.bbc.co.uk/programmes/#{pid}.json")["programme"]["ownership"]["service"]["key"]
		get_schedule(date, service).map{ |show| return new(show) if show["programme"]["pid"] == pid}
		if date > Date.today-1
			found = find_by_pid(pid, date-1,service)
			return found != nil ? new(found.info) : nil
		end
	end
	
	def self.get_schedule time, service
    @schedule_data = parse_json("#{Service.find_by_name(service).schedule}/#{time.year}/#{time.month}/#{time.day}.json")["schedule"]["day"]["broadcasts"]
	end

	def self.parse_json url
		JSON.parse(Net::HTTP.get(URI.parse(url)))
	end

	

	private_class_method :get_schedule, :parse_json, :new

end

