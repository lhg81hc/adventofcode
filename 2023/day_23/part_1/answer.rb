require_relative '../hiking_trail_map_parser'

module Day23
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        puts hiking_trail_map.two_d_map.first[1].char
      end

      def hiking_trail_map
        @hiking_trail_map ||= Day23::HikingTrailMapParser.parse(filepath)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
