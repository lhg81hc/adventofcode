require_relative 'rock'
require_relative 'bresenham_line'

module Year2022
  module Day14
    class LineOfRock
      include BresenhamLine

      attr_reader :first_rock, :last_rock

      def initialize(first_rock, last_rock)
        @first_rock = first_rock
        @last_rock = last_rock
      end

      def points
        plot_line(first_rock.x, first_rock.y, last_rock.x, last_rock.y)
      end
    end
  end
end
