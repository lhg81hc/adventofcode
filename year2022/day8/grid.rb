require_relative 'grid_utils'

module Year2022
  module Day8
    class Grid
      include GridUtils

      attr_reader :trees, :width, :height

      def initialize(trees = [])
        @trees = trees
        @height = trees.length
        @width = trees.first&.length || 0
      end

      def add_tree(line_index, char_index, tree)
        @trees[line_index] ||= []
        @trees[line_index].insert(char_index, tree)
        @height = line_index + 1 if line_index + 1 >= @height
        @width = char_index + 1 if char_index + 1 >= @width
        @columns = nil # reset columns
      end

      def total_trees
        @trees.inject(0) do |s, row|
          s += row.compact.length unless row.nil?
          s
        end
      end

      alias :rows :trees

      def columns
        @columns ||=
          begin
            return [] if width.zero?

            (0..width - 1).inject([]) do |l, column_index|
              l[column_index] = []
              rows.each { |row| l[column_index] << (row.nil? ? row : row[column_index]) }
              l
            end
          end
      end

      def row(row_index)
        return nil unless row_index >= 0 && row_index < height

        rows[row_index]
      end

      def column(column_index)
        return nil unless column_index >= 0 && column_index < width

        columns[column_index]
      end
    end
  end
end
