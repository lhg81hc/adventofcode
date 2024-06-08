module Year2022
  module Day6
    class Subroutine
      def first_marker_position(datastream:, num_of_distinct_chars:)
        start_index = 0
        end_index = datastream.length - 1

        until start_index > end_index
          if start_index >= num_of_distinct_chars
            str = datastream[(start_index - (num_of_distinct_chars - 1))..start_index]
            return (start_index + 1) unless string_has_duplicate?(str)
          end

          start_index += 1
        end

        nil
      end

      def string_has_duplicate?(str)
        hash = {}

        str.each_char do |char|
          hash[char] ||= 0
          hash[char] += 1

          return true if hash[char] > 1
        end

        false
      end
    end
  end
end
