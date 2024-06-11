module Year2022
  module Day8
    class Grid
      attr_reader :trees

      def initialize(trees = [])
        @trees = trees
      end

      def add_tree(line_index, char_index, tree)
        @trees[line_index] ||= []
        @trees[line_index].insert(char_index, tree)
      end

      def total_trees
        @trees.inject(0) do |s, row|
          s += row.compact.length unless row.nil?
          s
        end
      end
    end
  end
end
