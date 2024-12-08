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

      def find_bad_level
        # gradually increasing --> 1
        # gradually decreasing --> -1
        direction = nil
        num_of_levels = levels.length

        (0..(num_of_levels - 2)).each do |idx|
          return idx if levels[idx] == levels[idx + 1] # neither an increase or a decrease
          return idx if (levels[idx + 1] - levels[idx]).abs > 3

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

            return idx if current_direction != direction
          end
        end

        nil
      end

      def safe?
        find_bad_level.nil?
      end

      def unsafe?
        !safe?
      end

      def safe_without_any_bad_levels_or_with_a_single_bad_level?
        bad_level_idx = find_bad_level

        if bad_level_idx.nil?
          true
        else
          first_variation = levels.select.with_index { |_val, idx| idx != bad_level_idx - 1 }
          new_bad_level_idx = self.class.new(first_variation).find_bad_level

          if new_bad_level_idx.nil?
            true
          else
            second_variation = levels.select.with_index { |_val, idx| idx != bad_level_idx }
            new_bad_level_idx = self.class.new(second_variation).find_bad_level

            if new_bad_level_idx.nil?
              true
            else
              last_variation = levels.select.with_index { |_val, idx| idx != bad_level_idx + 1 }
              new_bad_level_idx = self.class.new(last_variation).find_bad_level
              new_bad_level_idx.nil?
            end
          end
        end
      end
    end
  end
end
