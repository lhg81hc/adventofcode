module Year2022
  module Day8
    module GridUtils
      def total_visible_trees_from_outside
        list = {}
        count = 0

        rows.each do |row|
          row.inject([]) do |arr, tree|
            visible_trees(arr, tree, list)
            arr
          end

          row.reverse_each.inject([]) do |arr, tree|
            visible_trees(arr, tree, list)
            arr
          end
        end

        columns.each do |column|
          column.inject([]) do |arr, tree|
            visible_trees(arr, tree, list)
            arr
          end

          column.reverse_each.inject([]) do |arr, tree|
            visible_trees(arr, tree, list)
            arr
          end
        end

        list.keys.count
      end

      def visible_trees(arr, tree, list)
        if arr.empty?
          arr << tree
          list[tree.to_s] = tree unless list[tree.to_s]
        else
          if tree.height > arr.last.height
            arr << tree
            list[tree.to_s] = tree unless list[tree.to_s]
          end
        end
      end

      def highest_scenic_score
        max = -1

        rows.each do |row|
          row.each do |tree|
            next if tree.around_the_edge?

            scenic_score = scenic_score_for_tree(tree)
            max = scenic_score if max < scenic_score
          end
        end

        max
      end

      def scenic_score_for_tree(tree)
        west_viewing_distance(tree) *
          east_viewing_distance(tree) *
          north_viewing_distance(tree) *
          south_viewing_distance(tree)
      end

      def west_viewing_distance(tree)
        blockage_index = west_view_blockage_index(tree)
        blockage_index.nil? ? tree.char_index : (tree.char_index - blockage_index)
      end

      def west_view_blockage_index(tree)
        (tree.char_index - 1).downto(0).find do |i|
          curr_tree = rows[tree.line_index][i]
          curr_tree.height >= tree.height
        end
      end

      def east_viewing_distance(tree)
        blockage_index = east_view_blockage_index(tree)
        blockage_index.nil? ? (width - 1 - tree.char_index) : (blockage_index - tree.char_index)
      end

      def east_view_blockage_index(tree)
        ((tree.char_index + 1)..(width - 1)).find do |i|
          curr_tree = rows[tree.line_index][i]
          curr_tree.height >= tree.height
        end
      end

      def north_viewing_distance(tree)
        blockage_index = north_view_blockage_index(tree)
        blockage_index.nil? ? tree.line_index : (tree.line_index - blockage_index)
      end

      def north_view_blockage_index(tree)
        (tree.line_index - 1).downto(0).find do |i|
          curr_tree = columns[tree.char_index][i]
          curr_tree.height >= tree.height
        end
      end

      def south_viewing_distance(tree)
        blockage_index = south_view_blockage_index(tree)
        blockage_index.nil? ? (height - 1 - tree.line_index) : (blockage_index - tree.line_index)
      end

      def south_view_blockage_index(tree)
        ((tree.line_index + 1)..(height - 1)).find do |i|
          curr_tree = columns[tree.char_index][i]
          curr_tree.height >= tree.height
        end
      end
    end
  end
end
