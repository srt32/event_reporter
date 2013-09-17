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
    assert_equal "Greg", parsed_data[0].first_name
    assert_equal "SAUNDERS", parsed_data[0].last_name
  end

end