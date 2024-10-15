module Year2022
  module Day14
    class Rock
      attr_accessor :coordinates

      def initialize(coordinates)
        @coordinates = coordinates
      end

      def x
        @x ||= coordinates.split(',').first.to_i
      end

      def y
        @y ||= coordinates.split(',').last.to_i
      end
    end
  end
end
