require_relative '../brick_landing_position_finder'
require_relative '../disintegratable_bricks_finder'
require_relative '../snapshot_parser'
require_relative '../snapshot'

module Day22
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        puts "\n"
        puts "Number of bricks that could be safely get disintegrated: #{disintergratable_bricks_counter.disinteratable_bricks.count}"
      end

      def landed_bricks
        @bricks_landed_position ||= Day22::BrickLandingPositionFinder.new(falling_bricks).land
      end

      def falling_bricks
        @falling_bricks ||= Day22::SnapshotParser.parse(filepath)
      end

      def disintergratable_bricks_counter
        @disintergratable_bricks_counter ||= Day22::DisintegratableBricksFinder.new(landed_bricks)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
