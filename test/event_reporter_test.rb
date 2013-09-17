require 'minitest'
require 'minitest/autorun'
require './lib/event_reporter'

class EventReporterTest < MiniTest::Test

  def test_it_exists
    er = EventReporter.new
    assert_kind_of EventReporter, er
  end

  def test_it_says_goodbye_when_command_is_quit
    er = EventReporter.new
    response = er.process_input("quit yeah")
    assert_equal "Goodbye!", response
  end

  def test_it_provides_a_list_of_commands_when_command_is_help
    er = EventReporter.new
    response = er.process_input("help")
    assert_equal "quit, help", response
  end

  def test_it_loads_a_file_when_command_is_load
    er = EventReporter.new
    er.process_input("load")
    assert_send([er, :load_csv_data])
  end

  def test_it_loads_data_properly_from_file
    er = EventReporter.new
    parsed_data = er.process_input("load")
    assert_kind_of Array, parsed_data
    assert_equal 4, parsed_data.count
    assert_equal "Allison", parsed_data[0].first_name
    assert_equal "Nguyen", parsed_data[0].last_name
  end

  def test_queue_is_empty_upon_startup
    er = EventReporter.new
    assert_nil @queue
  end

  def test_it_runs_queue_count_when_queue_is_called
    er = EventReporter.new
    parsed_data = er.process_input("queue")
    assert_send([er, :queue_method])
  end

    def test_it_returns_zero_for_queue_if_no_other_commands_called
    er = EventReporter.new
    parsed_data = er.process_input("queue")
    assert_equal 0, parsed_data
  end

  def test_attendees_is_empty_upon_startup
    er = EventReporter.new
    assert_nil @attendees
  end

  def test_it_calls_find_method_when_command_is_find
    er = EventReporter.new
    input = "find last_name SAUNDERS"
    er.process_input(input)
    assert_send([er, :find_parser, ["last_name", "SAUNDERS"]])
  end

  def test_it_gets_data_from_attendees_given_zip_code
    er = EventReporter.new
    er.process_input("load")
    input = "find zip_code 20010"
    results = er.process_input(input)
    assert_equal 2, results.count
  end

end