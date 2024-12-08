module Year2024
  module Day2
    class Report
      attr_reader :levels

      def initialize(levels)
        @levels = levels
      end

      def add_level(level)
        @levels << level
      end

      def safe?
        # gradually increasing --> 1
        # gradually decreasing --> -1
        direction = nil
        num_of_levels = levels.length

        (0..(num_of_levels - 2)).each do |idx|
          return false if levels[idx] == levels[idx + 1] # neither an increase or a decrease
          return false if (levels[idx + 1] - levels[idx]).abs > 3

          if idx.zero?
            direction =
              if levels[idx] > levels[idx + 1]
                -1
              elsif levels[idx] < levels[idx + 1]
                1
              end
          else
            current_direction =
              if levels[idx] > levels[idx + 1]
                -1
              elsif levels[idx] < levels[idx + 1]
                1
              end

            return false if current_direction != direction
          end
        end

        true
      end

      def unsafe?
        !safe?
      end
    end
  end
end