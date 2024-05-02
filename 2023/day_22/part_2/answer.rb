require_relative '../snapshot_parser'
require_relative '../falling_bricks_counter'

module Day22
  module Part2
    class Answer
      def self.run
        new.run
      end

      def run
        puts "\n"
        puts Day22::FallingBricksCounter.new(falling_bricks).total_falling_bricks_if_disintegrate_all_bricks_one_by_one
      end

      def falling_bricks
        @falling_bricks ||= Day22::SnapshotParser.parse(filepath)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
