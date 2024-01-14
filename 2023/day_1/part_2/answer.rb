# Your calculation isn't quite right. It looks like some of the digits are actually
# spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".
#
# Equipped with this new information, you now need to find the real first and last digit on each line. For example:
#
# two1nine
# eightwothree
# abcone2threexyz
# xtwone3four
# 4nineeightseven2
# zoneight234
# 7pqrstsixteen
#
# In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.
#
# What is the sum of all of the calibration values?

require '../part_2/line_parser'

module Part2
  class Answer
    attr_reader :sum

    def initialize
      @sum = 0
    end

    def self.run
      new.run
    end

    def run
      File.open(input_path).each do |line|
        parser = Part2::LineParser.new(line)
        @sum += parser.calibration_value

        puts parser.output
      end

      puts "\n\n"
      puts "The sum of all of the calibration values: #{sum}"
    end

    def input_path
      File.join(File.dirname(__FILE__), '/input.txt')
    end
  end
end
