module Day11
  class Vertex
    attr_reader :location, :value, :key

    def initialize(location, value)
      @location = location
      @value = value
      @key = location.join(',')
    end
  end
end
