module Year2022
  module Day6
    class Subroutine
      def find_marker_position(datastream:, num_of_distinct_chars:)
        start_index = 0
        end_index = datastream.length - 1

        until start_index > end_index
          if start_index >= num_of_distinct_chars
            str = datastream[(start_index - (num_of_distinct_chars - 1))..start_index]
            return (start_index + 1) if all_different_characters(str)
          end

          start_index += 1
        end

        nil
      end

      def all_different_characters(str)
        hash = {}

        str.each_char do |char|
          hash[char] ||= 0
          hash[char] += 1

          return false if hash[char] > 1
        end

        true
      end
    end
  end
end
