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

  def headers_row
     ["first_name","last_name","\n"]
  end

  def attendee_methods
    ["first_name", "last_name", "zip_code"] # add all the other methods here
  end

  def queue_print
    results_to_print = attendee_list.collect do |attendee|
      headers_row
      attendee_methods.collect do |method|
        attendee.send(method)
      end
    end
    results = headers_row.join(" ")
    results << results_to_print.join(" ")
  end

end
