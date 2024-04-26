require_relative '../snapshot_parser'
require_relative '../snapshot_perspective'

module Day22
  module Part1
    class Answer
      def initialize

      end

      def self.run
        new.run
      end

      def run
        # p bricks.first.first_coordinates_set
        # p bricks.first.second_coordinates_set
        # p bricks.first.num_of_cubes
        #
        # p snapshot_perspective.axis_perspective
        axis_perspective = snapshot_perspective.y_axis_perspective
        blank_row = Array.new(axis_perspective.first.length, ['.'])
        max_length = blank_row.length
        # axis_perspective.first.length.each do |n|
        #   printed_row =
        # end
        # puts axis_perspective.first.length
        axis_perspective.reverse.each do |row|
          printed_row = row
          printed_row = blank_row if row.nil?

          (0..(max_length - 1)).each do |cell_idx|
            cell = printed_row[cell_idx]
            if cell.nil?
              print '.'
            else
              if cell.length > 1
                print '?'
              else
                print(cell.first || '.')
              end
            end

            print ' '
          end

          print "\n"
        end
      end

      def snapshot_perspective
        @snapshot_perspective ||= Day22::SnapshotParser.parse(filepath)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
