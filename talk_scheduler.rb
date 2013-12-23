class TalksScheduler

	SESSION_DURATIONS = {
		:morning => [9, 12],
		:evening => [1, 5]
	}
	def initialize
	  @session_status = {
		:morning => "EMPTY",
		:evening => "EMPTY"
	   }

	  @scheduled_list = [] 
    end

def schedule_session(session, talks, time_suffix)
	session_start_time, session_end_time = SESSION_DURATIONS[session]
	talk_start_time = session_start_time*60

    remaining_talks = talks.reject do |talk|
       if(talk_end_time= talk_start_time + talk.first) <= session_end_time*60
    	  @scheduled_list << [talk_start_time.divmod(60).map{|each| each.to_s }.join("."),time_suffix, talk.reverse.join(" ")].join(" ")
    	  talk_start_time = talk_end_time
       end   
    end
    @session_status[session] = "FULL"
    remaining_talks
end

def schedule_track(track_id, talks)
	remaining_talks = schedule_session(:morning, talks, time_suffix = "AM")
	@scheduled_list << "12.00 PM Lunch Time"
	unless @session_status[:evening] == "FULL"
	  remaining_talks = schedule_session(:evening, remaining_talks, time_suffix = "PM")
	  @scheduled_list << "5:00 PM Networking Event "
	end
	remaining_talks
end

def schedule(talks)
	track_id = 1
	while talks.any?
		@scheduled_list << "Track #{track_id}:"
		talks = schedule_track(track_id, talks)
		@session_status = {:morning => 'EMPTY', :evening => 'EMPTY'}
		track_id += 1
	end
	puts @scheduled_list
end

end

lines = File.readlines(ARGV[0])

# Example:  talks = [
#   ["title1", 30],
#   ["title2", 20]
# ]

talks = lines.map do |line|
  talk, _, timestr = line.rstrip.rpartition(' ')
  timestr = 5 if timestr == 'lightning'
  [timestr.to_i, talk]
end.sort.reverse

TalksScheduler.new.schedule(talks)    
