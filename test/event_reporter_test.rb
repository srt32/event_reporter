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
    assert_equal "Available commands are: help, quit, load, queue, find.", response
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
    assert_equal 5175, parsed_data.count
    assert_equal "Allison", parsed_data[0].first_name
    assert_equal "Nguyen", parsed_data[0].last_name
  end

  def test_queue_is_empty_upon_startup
    er = EventReporter.new
    assert_nil @queue
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
    results = er.find_it("zip_code","20010")
    assert_equal 5, results.count
  end

  def test_it_gets_data_from_attendees_given_first_name
    er = EventReporter.new
    er.process_input("load")
    results = er.find_it("first_name","Sarah")
    assert_equal 76, results.count
  end

  def test_queue_has_correct_count_after_find 
    er = EventReporter.new
    er.process_input("load")
    results = er.find_it("first_name","Sarah")
    queue = er.send_results_to_queue(results)
    assert_equal(76, queue.count)
  end


  # below test should error because queue is being pushed to without being cleaned
  # to test, comment out empty_queue in send_results_to_queue
  def test_queue_has_correct_count_after_two_finds
    skip
    er = EventReporter.new
    er.process_input("load")
    results = er.find_it("first_name","Sarah")
    @queue = er.send_results_to_queue(results)
    results = er.find_it("zip_code","20010")
    @queue = er.send_results_to_queue(results)
    assert_equal(2, @queue.count)
    # maybe er.queue ???
  end

  def test_it_runs_queue_parser_when_queue_is_called
    er = EventReporter.new
    parsed_data = er.process_input("queue count")
    assert_send([er, :queue_parser, ["count"]])
  end

  def test_it_clears_queue_when_clear_queue_is_passed_to_queue_parser
    er = EventReporter.new
    results = er.queue_parser(["clear"])
    assert_equal true, results.empty?
  end

  def test_it_returns_count_when_count_is_passed_to_queue_parser
    er = EventReporter.new
    er.queue_parser("load")
    er.find_it("zip_code","20010")
    results = er.queue_parser(["clear"])
    assert_equal true, results.empty?
  end

  def test_it_runs_queue_print_parser_when_queue_print_is_called
    er = EventReporter.new
    parsed_data = er.process_input("queue print")
    assert_send([er, :queue_print_parser, ["print"]])
  end

  def test_it_runs_sort_queue_when_queue_print_by_is_called
    er = EventReporter.new
    parsed_data = er.process_input("queue print by first_name")
    sort_command = er.queue_print_parser(["print", "by", "first_name"])
    sort_queue_result = er.sort_queue("first_name")
    assert_equal sort_command, sort_queue_result
  end

  def it_should_print_by_zip_code_when_by_attribute_is_zip_code
    er = EventReporter.new
    er.process_input("load")
    er.process_input("find first_name Sarah")
    sorted_list = er.process_input("queue print by first_name")
    assert_equal 2, sorted_list
  end

end