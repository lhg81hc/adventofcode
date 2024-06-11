require_relative 'grid'
require_relative 'tree'

module Year2022
  module Day8
    class InputParser
      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def self.parse(*args, &block)
        new(*args).parse(&block)
      end

      def parse
        grid = Year2022::Day8::Grid.new
        line_index = 0

        File.foreach(filepath) do |line|
          parse_line(grid, line.strip, line_index)
          line_index += 1
        end

        grid.trees[line_index - 1].each { |tree| tree.on_bottom_edge = true }
        grid
      end

      private

      def parse_line(grid, line, line_index)
        char_index = 0

        while char_index < line.length do
          tree = Year2022::Day8::Tree.new(char_index, line_index, line[char_index].to_i)
          tree.on_right_edge = (char_index == line.length - 1)

          grid.add_tree(line_index, char_index, tree)

          char_index += 1
        end
      end
    end
  end
end
