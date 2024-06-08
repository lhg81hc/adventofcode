require_relative 'constants'

module Year2022
  module Day7
    class FilesystemNode
      include Constants

      attr_reader :name, :size, :parent_node, :child_nodes

      def initialize(name, size = nil, parent_node = nil, child_nodes = [])
        @name = name
        @size = size
        @parent_node = parent_node
        @child_nodes = child_nodes
      end

      def add_child_nodes(child_node)
        raise ArgumentError, "A file can not have any child" if file?

        @child_nodes << child_node
      end

      def parent_node=(node)
        raise ArgumentError, "Root directory can not have any parent" if root?

        @parent_node = node
      end

      def root?
        name == ROOT_DIRECTORY_NAME
      end

      def directory?
        root? || size.nil?
      end

      def file?
        !directory? && !size.nil?
      end

      alias :to_s :name
    end
  end
end
