gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/result.rb'
require './lib/attendee.rb'

class ResultTest < MiniTest::Test

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
    attendee1 = Attendee.new(:name => "One")
    attendee2 = Attendee.new(:name => "Two")
    attendees_array = []
    attendees_array.push(attendee1).push(attendee2)
    r_loaded = Result.new(attendees_array)
    refute r_loaded.nil?
  end

  def test_the_result_returns_an_array_of_attendees_when_asked
    attendee1 = Attendee.new(:name => "One")
    attendee2 = Attendee.new(:name => "Two")
    attendees_array = []
    attendees_array.push(attendee1).push(attendee2)
    r_loaded = Result.new(attendees_array)
    response = r_loaded.attendee_list
    assert_equal [attendee1,attendee2], response
  end

  def test_it_returns_correct_count_when_asked_queue_count
    attendee1 = Attendee.new(:name => "One")
    attendee2 = Attendee.new(:name => "Two")
    attendees_array = []
    attendees_array.push(attendee1).push(attendee2)
    r_loaded = Result.new(attendees_array)
    calculated_count = r_loaded.queue_count
    assert_equal 2, calculated_count
  end

end

