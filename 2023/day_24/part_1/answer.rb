require_relative '../input_parser'
require_relative '../testing_area'

module Day24
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        hailstones.each do |hailstone|
          print "#{hailstone} -> "
          print test_area.intersect_with_hailstone_future_path?(hailstone) ? "intersect" : "not intersect"
          puts "\n"
        end
      end

      def hailstones
        @hailstones ||= Day24::InputParser.parse(filepath)
      end

      def test_area
        @test_area ||= Day24::TestingArea.new(200000000000000, 400000000000000)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
