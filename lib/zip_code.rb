class ZipCode

  attr_reader :zip_code

  def initialize(zip_code)
    @zip_code  = clean_zipcode(zip_code)
  end

  def clean_zipcode(zipcode)
    zipcode ||= ""
    if zipcode.length < 4
      zipcode = "00000"
    else
      zipcode = zipcode.scan(/[0-9]/).join.rjust(5,"0")[0..4]
    end
  end

end