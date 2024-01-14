# https://adventofcode.com/2023/day/1
#
# The newly-improved calibration document consists of lines of text; each line originally contained a specific calibration
# value that the Elves now need to recover. On each line, the calibration value can be found by combining the first digit
# and the last digit (in that order) to form a single two-digit number.
#
# For example:
#
# 1abc2
# pqr3stu8vwx
# a1b2c3d4e5f
# treb7uchet
#
# In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.
#
# Consider your entire calibration document. What is the sum of all of the calibration values?

class Day1
  INPUT_FILE = "/input.txt"

  attr_reader :sum

  def initialize
    @sum = 0
  end

  def self.run
    new.run
  end

  def run
    File.open(input_path).each do |line|
      parser = LineParser.new(line)
      @sum += parser.calibration_value

      puts parser.output
    end

    puts "\n\n"
    puts "The sum of all of the calibration values: #{sum}"
  end

  def input_path
    File.join(File.dirname(__FILE__), INPUT_FILE)
  end
end

class LineParser
  NUMBER_SELECTORS = "^0-9"

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def numbers_only_str
    @numbers_only_str ||= value.delete(NUMBER_SELECTORS)
  end

  def number_characters
    @number_characters ||= numbers_only_str.chars
  end

  def first_found_digit
    numbers_only_str[0]
  end

  def last_found_digit
    numbers_only_str[-1]
  end

  def calibration_value
    ((first_found_digit || 0).to_i * 10) + (last_found_digit || 0).to_i
  end

  def output
    [
      value.strip,
      "[#{number_characters.join(', ')}]",
      calibration_value
    ].join(' --> ')
  end
end

Day1.run
