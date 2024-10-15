require_relative 'point'

module Year2022
  module Day14
    class LineOfRock
      attr_reader :starting_point, :ending_point

      def initialize(starting_point, ending_point)
        @starting_point = starting_point
        @ending_point = ending_point
      end
    end
  end
end
