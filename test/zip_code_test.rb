require 'minitest'
require 'minitest/autorun'
require './lib/zip_code'

class ZipCodeTest < MiniTest::Test

  def test_it_cleans_up_phone_numbers_with_periods_and_hyphens
    zip_code = ZipCode.new("202.44")
    assert_equal "20244", zip_code.zip_code
  end

  def test_it_cleans_up_zip_codes_with_spaces_and_parentheses
    zip_code = ZipCode.new("(202)92")
    assert_equal "20292", zip_code.zip_code
  end

  def test_it_throws_away_zip_codes_that_are_too_long
    zip_code = ZipCode.new("123456")
    assert_equal "12345", zip_code.zip_code
  end

  def test_it_add_zeros_to_front_for_zip_codes_that_are_too_short
    zip_code = ZipCode.new("1234")
    assert_equal "01234", zip_code.zip_code
  end

  def test_it_add_zeros_to_front_for_zip_codes_that_are_four_digits
    zip_code = ZipCode.new("1234")
    assert_equal "01234", zip_code.zip_code
  end

  def test_it_throws_out_zip_codes_that_are_too_short
    zip_code = ZipCode.new("123")
    assert_equal "00000", zip_code.zip_code
  end

end