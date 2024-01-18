module Day4
  module Part2
    class TreeNode
      attr_reader :parent_value, :children

      def initialize(parent_value = nil, children = [])
        @parent_value = parent_value
        @children = children
      end
    end
  end
end
