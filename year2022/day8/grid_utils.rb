module Year2022
  module Day8
    module GridUtils
      def total_visible_trees_from_outside
        list = {}

        process_rows_or_columns(rows, list)
        process_rows_or_columns(rows.map(&:reverse), list)
        process_rows_or_columns(columns, list)
        process_rows_or_columns(columns.map(&:reverse), list)

        list.keys.count
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

      private

      def process_rows_or_columns(rows_or_columns, list)
        rows_or_columns.each do |line|
          line.inject([]) { |visible, tree| add_visible_tree(visible, tree, list) }
        end
      end

      def add_visible_tree(visible, tree, list)
        if visible.empty? || tree.height > visible.last.height
          visible << tree
          list[tree.to_s] ||= true
        end

        visible
      end

      def scenic_score_for_tree(tree)
        [:west, :east, :north, :south].inject(1) { |score, direction| score * distance_to_blockage(tree, direction) }
      end

      def distance_to_blockage(tree, direction)
        blockage_index = send("#{direction}_view_blockage_index", tree)

        case direction
        when :west
          blockage_index.nil? ? tree.char_index : (tree.char_index - blockage_index)
        when :east
          blockage_index.nil? ? (width - tree.char_index - 1) : (blockage_index - tree.char_index)
        when :north
          blockage_index.nil? ? tree.line_index : (tree.line_index - blockage_index)
        when :south
          blockage_index.nil? ? (height - tree.line_index - 1) : (blockage_index - tree.line_index)
        else
          0 # never happen
        end
      end

      def west_view_blockage_index(tree)
        (tree.char_index - 1).downto(0).find { |i| rows[tree.line_index][i].height >= tree.height }
      end

      def east_view_blockage_index(tree)
        ((tree.char_index + 1)...width).find { |i| rows[tree.line_index][i].height >= tree.height }
      end

      def north_view_blockage_index(tree)
        (tree.line_index - 1).downto(0).find { |i| columns[tree.char_index][i].height >= tree.height }
      end

      def south_view_blockage_index(tree)
        ((tree.line_index + 1)...height).find { |i| columns[tree.char_index][i].height >= tree.height }
      end
    end
  end
end
