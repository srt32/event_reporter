require 'minitest'
require 'minitest/autorun'
require './lib/attendee'

class AttendeeTest < MiniTest::Test

  def test_it_exists
    attendee = Attendee.new
    assert_kind_of Attendee, attendee
  end

end