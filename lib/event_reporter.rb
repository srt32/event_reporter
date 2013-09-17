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
      when "queue" then queue_method
      when "find" then find_parser(directive)
    end
  end

  def find_parser(directive)
    attribute = directive[0]
    criteria = directive[1..-1].join(" ")
    results = find_it(attribute,criteria)
    return results
  end

  def find_it(attribute,criteria)
    results = []
    @attendees.each do |attendee|
      if attendee.send(attribute) == criteria
        results.push(attendee)
        puts attendee
      end
    end
    return results
  end

  def queue_method
    0
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