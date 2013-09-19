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
      printf "Enter your command:"
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
      when "save"  then queue_save(directive)
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

  def queue_save(directive)
    # binding.pry
    save_filename = directive[2..-1].join("")
    # binding.pry
    #save_filename ||= "output_from_event_reporter.csv"
    #save_file_path = "#{save_filename}"
    save_file = File.open(save_filename, "w")
    # binding.pry

    attendee_array = @queue.collect do |attendee|
       [attendee.email, attendee.first_name, attendee.last_name, attendee.phone_number, attendee.zip_code, attendee.city, attendee.state, attendee.address]
    end

    attendee_array.each_with_index do |a_csv, i|
      queue_csv = CSV.generate do |csv|
        csv << a_csv
      end
      if i == 0
        save_file.write('email,first_name,last_name,phone_number,zip_code,city,state,address\t')
      end
      save_file.write(queue_csv)
    end
    save_file.close
    return save_file

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
    puts "LAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"
    @queue.each do |attendee|
      puts "#{attendee.last_name}\t\t#{attendee.first_name}\t\t#{attendee.email}\t\t#{attendee.zip_code}\t\t#{attendee.city}\t\t#{attendee.state}\t\t#{attendee.address}\t\t#{attendee.phone_number}"
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
