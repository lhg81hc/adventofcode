module Year2022
  module Day6
    class Subroutine
      def find_marker_position(datastream)
        start_index = 0
        end_index = datastream.length - 1

        until start_index > end_index
          if start_index >= 4
            str = datastream[(start_index - 3)..start_index]
            return (start_index + 1) if all_four_different_characters(str)
          end

          start_index += 1
        end

        nil
      end

      def all_four_different_characters(str)
        return false if str[0] == str[1]
        return false if str[2] == str[3]

        (str[0..1].chars & str[2..3].chars).empty?
      end
    end
  end
end
