module Year2022
  module Day8
    class VisibleTreeCounter
      attr_reader :grid

      def initialize(grid)
        @grid = grid
      end

      def count
        @list = {}
        @count = 0

        @grid.trees.each do |row|
          visible_tree_in_current_direction(row)
          visible_tree_in_opposite_direction(row)
        end

        (0..@grid.width - 1).each do |column_index|
          column = grid.column(column_index)
          visible_tree_in_current_direction(column)
          visible_tree_in_opposite_direction(column)
        end

        @count
      end

      def visible_tree_in_current_direction(trees)
        arr = []
        trees.each { |tree| shadowed_by_prev_indexes?(arr, tree) }
        arr
      end

      def visible_tree_in_opposite_direction(trees)
        arr = []
        trees.reverse.each { |tree| shadowed_by_prev_indexes?(arr, tree) }
        arr
      end

      def shadowed_by_prev_indexes?(arr, tree)
        result = true

        if arr.empty?
          arr << tree
          result = false

          unless @list[tree.to_s]
            @list[tree.to_s] = tree
            @count += 1
          end
        else
          if tree.height > arr.last.height
            arr << tree
            result = false

            unless @list[tree.to_s]
              @list[tree.to_s] = tree
              @count += 1
            end
          end
        end

        result
      end
    end
  end
end
