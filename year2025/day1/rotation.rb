module Year2025
  module Day1
    class Rotation
      attr_reader :str, :direction, :clicks

      def initialize(str)
        @str = str
        @raw = str.strip
        parse!
      end

      def to_the_left?
        direction == 'L'
      end

      def to_the_right?
        direction == 'R'
      end

      def to_i
        to_the_left? ? -clicks : clicks
      end

      def parse!
        @direction = @raw.scan(/[A-Z]/).first
        @clicks = @raw.scan(/\d+/).first&.to_i
      end
    end
  end
end
