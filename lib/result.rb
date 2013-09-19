require 'pry'

class Result

  attr_reader :attendee_list 
  
  def initialize(input = [])
    @attendee_list = input
  end

  def queue_count
    attendee_list.count
  end

  def queue_clear
    attendee_list = []
  end

  def queue_sort(attribute)
    sorted_list = attendee_list.sort_by {|attendee| attendee.send(attribute)}
  end

  def queue_print 
    results_to_print = attendee_list.collect {|attendee| attendee.instance_variables.each {|var| attendee.send(var.to_s.gsub("@",""))}}
    results_to_print = results_to_print.join(" ")
    puts results_to_print
    return results_to_print
  end

end
