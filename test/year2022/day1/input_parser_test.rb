require 'test/unit'
require './year2022/day1/input_parser'

module Day1
  class InputParserTest < Test::Unit::TestCase
    def setup
      @filepath = File.join(File.dirname(__FILE__), 'input.txt')
      @input_parser = Day1::InputParser.new(@filepath)
    end

    def test_parse
      assert_equal([[1000, 2000, 3000], [4000], [5000, 6000], [7000, 8000, 9000], [10_000]], @input_parser.parse)
    end
  end
end
