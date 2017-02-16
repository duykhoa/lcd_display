class LCDDisplay
  # Constructor
  #
  # Params:
  # +size+: size of LCD digits
  #    for example: with size = 1, num = 2
  #     --
  #       |
  #       |
  #     --
  #    |
  #    |
  #     --
  # +values+ values to display, can be a list of numbers
  #   for example: 1234567890
  #
  def initialize(size, values)
    @values = values
    @size = size
  end

  # Send rendered output to STDIO
  # Params: no
  #
  # Examples
  #   @lcd = LCDDisplay.new(1, 123456789)
  #   @lcd.display
  def display
    puts render
  end

  # Render @values to a buffer line by line
  def render
    lines.times do |line_no|
      buffer << compiled_string_at(line_no)
      buffer << "\n"
    end

    buffer
  end

  # Compile values at a line_no
  # There are 3 special line 0, line/2, line. These lines
  # can be filled with dash (-) or blank( )
  def compiled_string_at(line_no)
    line_str = ""

    value_arr.each do |num|
      if dash_lines.keys.include?(line_no)
        line_str << dash_or_blank_fill(line_no, num)
      else
        line_str << bars(line_no, num)
      end

      line_str << " "
    end

    line_str
  end

  # Fill special line (0, line/2, line) with dash or blank
  def dash_or_blank_fill(line_no, num)
    dash_lines[line_no].include?(num) ?  dashs : blanks
  end

  def bars(line_no, num)
    if line_no < lines / 2
      top_bar(num)
    elsif line_no > line_no / 2
      bottom_bar(num)
    end
  end

  def top_bar(num)
    if [1, 2, 3, 7].include?(num)
      right_bar
    elsif [5, 6].include?(num)
      left_bar
    else
      all_bar
    end
  end

  def bottom_bar(num)
    if [1, 3, 4, 5, 7, 9].include?(num)
      right_bar
    elsif [6, 8, 0].include?(num)
      all_bar
    else
      left_bar
    end
  end

  def value_arr
    @values.to_s.split('').map { |item| item.to_i }
  end

  def buffer
    @buffer ||= String.new
  end

  # top lines, bottom lines, plus 3 special lines
  def lines
    2 * @size + 3
  end

  def dash_lines
    @_dash_lines ||= {
      0 => [2, 3, 5, 6, 7, 8, 9, 0],
      lines/2 => [2, 3, 4, 5, 6, 8, 9],
      lines - 1 => [2, 3, 5, 6, 8, 9, 0]
    }
  end

  def all_bar
    "|%s|" % [ " " * @size ]
  end

  def left_bar
    "|%s " % [ " " * @size ]
  end

  def right_bar
    " %s|" % [ " " * @size ]
  end

  def dashs
    " %s " % [ "-" * @size ]
  end

  def blanks
    " %s " % [ " " * @size ]
  end
end
