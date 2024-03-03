module Day16
  class Graph
    attr_accessor :nodes

    def initialize
      @nodes = {}
    end

    def add_node(node)
      @nodes[node.val] = node
    end

    def add_edge(predecessor_name, successor_name)
      nodes[predecessor_name].add_edge(nodes[successor_name])
    end

    def [](val)
      nodes[val]
    end
  end
end
