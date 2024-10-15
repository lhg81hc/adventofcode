module Year2022
  module Day14
    class Point
      attr_accessor :str

      def initialize(str)
        @str = str
      end

      def x
        @x ||= str.split(',').first.to_i
      end

      def y
        @y ||= str.split(',').last.to_i
      end
    end
  end
end
