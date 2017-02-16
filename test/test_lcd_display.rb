require_relative '../lcd_display'
require 'minitest/autorun'

class LCDDisplayTest < Minitest::Test
  def test_value_arr
    @display = LCDDisplay.new(1, 1232)
    assert_equal([1,2,3,2], @display.value_arr)
  end

  def test_lines
    @display = LCDDisplay.new(1, 1232)
    assert_equal(5, @display.lines)
  end

  def test_compiled_string_at
    @display = LCDDisplay.new(1, 1)

    line_0 = "    "
    line_1 = "  | "
    line_2 = "    "
    line_3 = "  | "
    line_4 = "    "

    assert_equal(line_0, @display.compiled_string_at(0))
    assert_equal(line_1, @display.compiled_string_at(1))
    assert_equal(line_2, @display.compiled_string_at(2))
    assert_equal(line_3, @display.compiled_string_at(3))
    assert_equal(line_4, @display.compiled_string_at(4))
  end
end
