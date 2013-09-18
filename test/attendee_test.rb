require 'minitest'
require 'minitest/autorun'
require './lib/attendee'

class AttendeeTest < MiniTest::Test

  def test_it_exists
    attendee = Attendee.new
    assert_kind_of Attendee, attendee
  end

  def test_it_is_initialized_from_a_hash_of_data
    data = {:first_name => 'George', :last_name => 'Washington', :phone_number => '2024556677', :zip_code => '12345', :email => "foobar@example.com", :city => "Denver", :state => "CO", :address => "1062 Delaware St. Unit 4b"}
    attendee = Attendee.new(data)
    assert_equal data[:first_name], attendee.first_name
    assert_equal data[:last_name], attendee.last_name
    assert_equal data[:phone_number], attendee.phone_number
    assert_equal data[:zip_code], attendee.zip_code
    assert_equal data[:email], attendee.email
    assert_equal data[:city], attendee.city
    assert_equal data[:state], attendee.state
    assert_equal data[:address], attendee.address
  end



end
