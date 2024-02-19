module Day11
  class Edge
    attr_reader :first_point_name, :second_point_name, :weight

    def initialize(first_point_name, second_point_name, weight)
      @first_point_name = first_point_name
      @second_point_name = second_point_name
      @weight = weight
    end
  end
end
