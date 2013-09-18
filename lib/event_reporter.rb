require 'csv'
require './lib/attendee'

class EventReporter
  attr_accessor :queue, :attendees

  def initialize
    @queue = []
    @attendees = []
  end

  def run
    puts "Welcome to EventReporter"

    command = ""
    while command != "quit"
      printf "Enter your command:"
      user_input = gets.chomp
      command = user_input.split(" ")[0]
      response = process_input(user_input)
      puts response
    end
  end

  def process_input(user_input)
    command = user_input.split(" ")[0]
    directive = user_input.split(" ")[1..-1]
    case command
      when "quit" then "Goodbye!"
      when "help" then "quit, help" # 2 options
      when "load" then load_csv_data
      when "queue" then queue_parser(directive)
      when "find" then find_parser(directive)
    end
  end

  def find_parser(directive)
    # add code to trap if "load" has not yet been run
    attribute = directive[0]
    criteria = directive[1..-1].join(" ")
    find_and_add_to_queue(attribute,criteria)
    
  end

  def find_and_add_to_queue(attribute,criteria)
    results = find_it(attribute,criteria)
    send_results_to_queue(results)
  end

  def find_it(attribute,criteria)
    @attendees.find_all {|attendee| attendee.send(attribute) == criteria}
  end

  def send_results_to_queue(results)
    clear_queue
    @queue = results.collect {|result| result}
    return @queue
  end

  def queue_parser(directive)
    # commands: count, clear, print, print by, print to
    queue_command = directive[0]
    case queue_command
      when "clear" then clear_queue
      when "count" then count_queue
    #   when print then print_parser # print by, print to #print_queue  
    # end
    end
  end

  def clear_queue
    @queue = []
  end  

  def count_queue
    @queue.count
  end

  def print_queue
    @queue.each do |attendee|
      puts "First name:  #{attendee.first_name}"
      puts "Zip code:  #{attendee.zip_code}"
    end
  end

  def load_csv_data(filename = "event_attendees_test.csv")
    data = import_csv(filename)
    create_attendees(data)
  end

  def import_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def create_attendees(data)
    @attendees = data.collect do |row|
      Attendee.new(:id => row[0], :first_name => row[:first_name], :last_name => row[:last_name], :zip_code => row[:zipcode])
    end
    return attendees
  end

end

if __FILE__ == $0
  er = EventReporter.new
  er.run
end