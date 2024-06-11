module Year2022
  module Day8
    class Grid
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
      end

      def total_trees
        @trees.inject(0) do |s, row|
          s += row.compact.length unless row.nil?
          s
        end
      end

      def row(row_index)
        return nil unless row_index >= 0 && row_index < height

        trees[row_index]
      end

      def column(column_index)
        return nil unless column_index >= 0 && column_index < width

        trees.inject([]) do |s, row|
          s << row[column_index]
          s
        end
      end
    end
  end
end
