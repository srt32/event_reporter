gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/result.rb'
require './lib/attendee.rb'

class ResultTest < MiniTest::Test

  def setup
    @attendee1 = Attendee.new(:first_name => "One")
    @attendee2 = Attendee.new(:first_name => "Two", :last_name => "Apples")
    attendees_array = []
    attendees_array.push(@attendee1).push(@attendee2)
    @r_loaded = Result.new(attendees_array)
  end

  def test_it_exists
    r = Result.new
    assert_kind_of Result, r
  end

  def test_the_queue_starts_as_an_empty_array
    r = Result.new
    attendee_list = r.attendee_list
    assert 0, attendee_list.length
  end

  def test_the_result_can_accept_an_array
   refute @r_loaded.nil?
  end

  def test_the_result_returns_an_array_of_attendees_when_asked
    response = @r_loaded.attendee_list
    assert_equal [@attendee1,@attendee2], response
  end

  def test_it_returns_correct_count_when_asked_queue_count
    calculated_count = @r_loaded.queue_count
    assert_equal 2, calculated_count
  end

  def test_returns_attendee_list_is_empty_after_asked_queue_clear
    new_attendees = @r_loaded.queue_clear
    assert_equal [], new_attendees
  end

  def test_it_sorts_the_attendees_list_properly_given_first_name
    sorted_attendees = @r_loaded.queue_sort("first_name").reverse
    assert_equal [@attendee2,@attendee1],sorted_attendees
  end

  def test_it_can_print_attendees_list_to_user_when_asked_queue_print
    printed_results = @r_loaded.queue_print
    assert_includes printed_results, "apples"

  end
end

