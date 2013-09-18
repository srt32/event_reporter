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
    assert_equal "Available commands are: help, quit, load, queue, find, print.", response
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
    assert_equal 2, results.count
  end

  def test_it_gets_data_from_attendees_given_first_name
    er = EventReporter.new
    er.process_input("load")
    results = er.find_it("first_name","Sarah")
    assert_equal 2, results.count
  end

  def test_queue_has_correct_count_after_find 
    er = EventReporter.new
    er.process_input("load")
    results = er.find_it("first_name","Sarah")
    queue = er.send_results_to_queue(results)
    assert_equal(2, queue.count)
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
  end

  def test_it_returns_empty_for_queue_if_no_other_commands_called
    er = EventReporter.new
    parsed_data = er.process_input("queue")
    assert_equal true, parsed_data.nil?
  end

  def test_it_returns_zero_for_queue_if_only_load_is_called
    er = EventReporter.new
    er.process_input("load")
    parsed_data = er.process_input("queue")
    assert_equal true, parsed_data.nil?
  end

    # this test needs to be updated to make sure it actually calls queue_count
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

end