module Day11
  class Edge
    attr_reader :points, :weight

    def initialize(points = [], weight = nil)
      @points = points
      @weight = weight
    end
  end
end
