require 'test/unit'
require_relative '../../../year2024/day1/list_parser'

module Year2024
  module Day1
    class ListParserTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), '../input.txt')
        @list_parser = Year2024::Day1::ListParser.new(@input_path)
      end

      def test_initialization
        assert_equal(@list_parser.input_path.to_s, File.join(File.dirname(__FILE__), '../input.txt'))
      end

      def test_parse
        lists = @list_parser.parse

        assert_equal([3, 4, 2, 1, 3, 3], lists[0])
        assert_equal([4, 3, 5, 3, 9, 3], lists[1])
      end
    end
  end
end
