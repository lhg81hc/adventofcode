require_relative '../input_parser'

module Day24
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        p hailstones.first.position
        p hailstones.last.velocity
      end

      def hailstones
        @hailstones ||= Day24::InputParser.parse(filepath)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
