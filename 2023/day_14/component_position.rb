module Day14
  class ComponentPosition
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def to_s
      "#{x},#{y}"
    end
  end
end
