module Day11
  class Vertex
    attr_reader :name, :neighbors, :weights, :location

    def initialize(location)
      @location = location
      @name = location.join(',')
      @neighbors = []
      @weights = []
    end

    def add_neighbor_and_weight(neighbor, weight)
      @neighbors << neighbor
      @weights << weight
    end
  end
end
