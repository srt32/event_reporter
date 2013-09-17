class Attendee
  attr_accessor :first_name, :last_name, :phone_number, :zip_code

  def initialize(input = {})
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @phone_number = PhoneNumber.new(input[:phone_number]).number
    @zip_code = input[:zip_code]
  end

end