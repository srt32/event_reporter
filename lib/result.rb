class Result

  attr_reader :attendee_list 
  
  def initialize(input = [])
    @attendee_list = input
  end

  def queue_count
    attendee_list.count
  end
end
