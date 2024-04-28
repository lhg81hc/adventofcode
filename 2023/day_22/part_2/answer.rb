require_relative '../snapshot_parser'
require_relative '../test'

module Day22
  module Part2
    class Answer
      def self.run
        new.run
      end

      def run
        puts "\n"
        puts Day22::Test.new(falling_bricks).count
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
