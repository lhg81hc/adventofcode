module Day11
  class WeightedGraph
    attr_reader :vertices, :edges

    def initialize(vertices = [])
      @vertices = vertices
      @edges = []
    end

    def add_vertex(vertex)
      @vertices << vertex
    end

    def add_edges(list)
      @edges.concat(list)
    end
  end
end
