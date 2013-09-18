require 'csv'
require './lib/attendee'
require 'pry'

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
      printf "Enter your comgmand:"
      user_input = gets.chomp
      command = user_input.split(" ")[0]
      response = process_input(user_input)
      puts response unless response.class == Array
    end
  end

  def process_input(user_input)
    user_input = user_input.downcase
    command = user_input.split(" ")[0]
    directive = user_input.split(" ")[1..-1]
    case command
      when "quit" then "Goodbye!"
      when "help" then help_output
      when "load" then load_csv_data
      when "queue" then queue_parser(directive)
      when "find" then find_parser(directive)
    end
  end

  def help_output
    "Available commands are: help, quit, load, queue, find."
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
    criteria = criteria.chomp(" ")
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
      when "print" then queue_print_parser(directive)
    end
  end

  def queue_print_parser(directive)
    queue_print_by = directive[1]
    attribute = directive[2..-1]
    case queue_print_by
      when nil then print_queue
      else sort_and_print_queue(attribute)
    end
  end

  def sort_and_print_queue(attribute)
    attribute = attribute.join
    sort_queue(attribute)
    print_queue
  end

  def sort_queue(attribute)
    @queue = @queue.sort_by {|attendee| attendee.send(attribute)}
  end

  def print_queue
    @queue.each do |attendee|
      puts "First name:  #{attendee.first_name}"
      puts "Zip code:  #{attendee.zip_code}"
    end
  end

  def clear_queue
    @queue = []
  end  

  def count_queue
    @queue.count
  end

  def load_csv_data(filename = "event_attendees.csv")
    data = import_csv(filename)
    create_attendees(data)
  end

  def import_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def create_attendees(data)
    @attendees = data.collect do |row|
      Attendee.new(:id => row[0], :first_name => row[:first_name], :last_name => row[:last_name], :zip_code => row[:zipcode], :email => row[:email_address], :phone_number => row[:homephone], :address => row[:street], :city => row[:city], :state => row[:state])
    end
    # return attendees
  end

end

if __FILE__ == $0
  er = EventReporter.new
  er.run
end
