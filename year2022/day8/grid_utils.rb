module Year2022
  module Day8
    module GridUtils
      def total_visible_trees
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
    end
  end
end
