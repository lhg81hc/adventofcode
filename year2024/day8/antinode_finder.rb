module Year2024
  module Day8
    module AntinodeFinder

      def find_antinode_locations_by_frequency(frequency)
        filtered_antennas = filter_antennas_by_frequency(frequency)
        filtered_antennas_count = filtered_antennas.length
        result = Set.new([])

        filtered_antennas.each.with_index do |antenna, antenna_index|
          next if filtered_antennas[antenna_index + 1].nil?

          ((antenna_index + 1)..(filtered_antennas_count - 1)).each do |next_antenna_index|
            valid_antinode_locations_by_two_antennas(antenna, filtered_antennas[next_antenna_index]).each do |str|
              result.add(str)
            end
          end
        end

        result
      end

      # Idea: An antinode is actually a reflection of an antenna through another antenna,
      #       Therefore the problem become: find the reflection of a location through another location
      def antinode_location(first_antenna, second_antenna)
        [
          first_antenna.row_index + (first_antenna.row_index - second_antenna.row_index),
          first_antenna.char_index + (first_antenna.char_index - second_antenna.char_index)
        ]
      end

      def valid_antinode_location?(row_index, char_index)
        (row_index >= 0 && row_index <= height - 1) && (char_index >= 0 && char_index <= width - 1)
      end

      def valid_antinode_locations_by_two_antennas(first_antenna, second_antenna)
        r = []
        row_index, char_index = antinode_location(first_antenna, second_antenna)
        r << "#{row_index},#{char_index}" if valid_antinode_location?(row_index, char_index)

        row_index, char_index = antinode_location(second_antenna, first_antenna)
        r << "#{row_index},#{char_index}" if valid_antinode_location?(row_index, char_index)

        r
      end
    end
  end
end
