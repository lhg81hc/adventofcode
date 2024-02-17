module Day11
  class WeightedGraph
    attr_reader :vertices, :edges

    def initialize(vertices = [])
      @vertices = vertices
    end

    def add_vertex(vertex)
      @vertices << vertex
    end

    def find_vertex_by_name(name)
      vertices.find { |v| v.name == name }
    end
  end
end
