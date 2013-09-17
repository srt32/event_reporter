require 'minitest'
require 'minitest/autorun'
require './lib/command'

class CommandTest < MiniTest::Test

  def test_it_exists
    command = Command.new
    assert_kind_of Command, command
  end

  

end

 # data = {:first_name => 'George', :last_name => 'Washington', :phone_number => '2024556677', :zip_code => '12345'}
 #    attendee = Attendee.new(data)
 #    assert_equal data[:first_name], attendee.first_name
 #    assert_equal data[:last_name], attendee.last_name
 #    assert_equal data[:phone_number], attendee.phone_number
 #    assert_equal data[:zip_code], attendee.zip_code