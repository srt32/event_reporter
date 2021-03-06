require './lib/phone_number'
require './lib/zip_code'

class Attendee
  attr_accessor :first_name, :last_name, :phone_number, :zip_code, :email, :city, :state, :address

  def initialize(input = {})
    @first_name = clean_first_name(input[:first_name])
    @last_name = clean_last_name(input[:last_name])
    @phone_number = PhoneNumber.new(input[:phone_number]).number
    @zip_code = ZipCode.new(input[:zip_code]).zip_code
    @email = clean_email(input[:email])
    @city = clean_city(input[:city])
    @state = clean_state(input[:state])
    @address = clean_address(input[:address])
  end

  def convert_to_string_and_downcase(input)
    input.to_s.downcase
  end

  def clean_first_name(input)
    convert_to_string_and_downcase(input)
  end

  def clean_last_name(input)
    convert_to_string_and_downcase(input)
  end

  def clean_email(input)
    convert_to_string_and_downcase(input)
  end

  def clean_city(input)
    convert_to_string_and_downcase(input)
  end

  def clean_state(input)
    convert_to_string_and_downcase(input)
  end
  
  def clean_address(input)
    convert_to_string_and_downcase(input)
  end


end
