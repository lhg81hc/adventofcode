module Year2025
  module Day1
    module Part1
      class Rotation
        attr_reader :str, :direction, :num_of_clicks

        def initialize(str)
          @str = str
        end

        def direction
          str.scan(/[A-Z]/).first
        end

        def num_of_clicks
          str.scan(/\d+/).first&.to_i
        end

        def to_the_left?
          direction == 'L'
        end

        def to_the_right?
          direction == 'R'
        end
      end
    end
  end
end
