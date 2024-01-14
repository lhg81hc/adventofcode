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

require '../part_1/line_parser'
# require 'line_parser'

module Part1
  class Answer
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
        parser = Part1::LineParser.new(line)
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
end
