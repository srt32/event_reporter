require 'csv'
require './lib/attendee'

class EventReporter
  attr_accessor :queue

  def initialize
    @queue = []
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
    puts "high level directive is #{directive}"
    case command
      when "quit" then "Goodbye!"
      when "help" then "quit, help" # 2 options
      when "load" then load_csv_data
      when "queue" then queue_method
      when "find" then find_parser(directive)
    end
  end

  def find_parser(directive)
    puts "directive is #{directive}"
    param = directive[0] # BREAKING UP THE WORDS WRONG
    param_value = directive[1..-1]
    puts "param is #{param} and param_value is #{param_value}"
    true
  end

  def queue_method
    0
  end

  def load_csv_data(filename = "event_attendees_test.csv")
    data = import_csv(filename)
    parsed_data = parse_data(data)
    create_attendees(parsed_data)
  end

  def import_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def parse_data(data) # needs to be fixedXXX
    parsed_data = []
    attendee_data = {}
    data.each do |row|
      attendee_data[:id] = row[0]
      attendee_data[:name] = row[:first_name]
      attendee_data[:last_name] = row[:last_name]
    end
    parsed_data.push(attendee_data)
    return parsed_data
    puts parsed_data
  end

  def create_attendees(parsed_data)
    attendees = parsed_data.collect do |row|
      Attendee.new(:id => row[:id], :first_name => row[:name], :last_name => row[:last_name])
    end
    return attendees
    puts attendees
  end

end

if __FILE__ == $0
  er = EventReporter.new
  er.run
end