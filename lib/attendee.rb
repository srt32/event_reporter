require './lib/phone_number'
require './lib/zip_code'

class Attendee
  attr_accessor :first_name, :last_name, :phone_number, :zip_code

  def initialize(input = {})
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @phone_number = PhoneNumber.new(input[:phone_number]).number
    @zip_code = ZipCode.new(input[:zip_code]).zip_code
  end

end
