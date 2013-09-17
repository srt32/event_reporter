require 'csv'

class EventReporter

  def initialize
    puts "Initializing -- Welcome"
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
      # when "queue" then "xxx" # many options
      # when "find" then "xxx" # options
    end
  end

  def load_csv_data(filename = "event_attendees.csv")
    data = import_csv(filename)
    parsed_data = parse_data(data)
    create_attendees(parsed_data)
  end

  def import_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def parse_data(data)
    parsed_data = {}
    data.each do |row|
      parsed_data[:id] = row[0]
      parsed_data[:name] = row[:first_name]
      parsed_data[:last_name] = row[:last_name]
    end
    return parsed_data
  end

  def create_attendees(parsed_data)
    attendees = parsed_data.collect do |row|
      attendee = Attendee.new(:id => parsed_data[:id], :first_name => parsed_data[:name], :last_name => parsed_data[:last_name])
    end
    return attendees
  end

end

er = EventReporter.new
er.run