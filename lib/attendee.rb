class Attendee
  attr_reader :first_name, :last_name, :phone_number, :zip_code

  def initialize(input = {})
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @phone_number = input[:phone_number]
    @zip_code = input[:zip_code]
  end

end