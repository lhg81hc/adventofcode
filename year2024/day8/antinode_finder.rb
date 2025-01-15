module Year2024
  module Day8
    module AntinodeFinder
      def find_antinode_locations_by_frequency(frequency, consider_resonant_harmonics_effect: false)
        filtered_antennas = filter_antennas_by_frequency(frequency)
        filtered_antennas_count = filtered_antennas.length
        result = Set.new([])

        filtered_antennas.each.with_index do |antenna, antenna_index|
          next if filtered_antennas[antenna_index + 1].nil?

          ((antenna_index + 1)..(filtered_antennas_count - 1)).each do |next_antenna_index|
            if consider_resonant_harmonics_effect
              antinode_locations_under_resonant_harmonics_effect(antenna, filtered_antennas[next_antenna_index]).each do |str|
                result.add(str)
              end
            else
              antinode_locations(antenna, filtered_antennas[next_antenna_index]).each do |str|
                result.add(str)
              end
            end
          end
        end

        result
      end

      # Idea: An antinode is actually a reflection of an antenna through another antenna,
      #       Therefore the problem become: find the reflection of a location through another location
      def reflection_location(first_antenna, second_antenna)
        [
          first_antenna.row_index + (first_antenna.row_index - second_antenna.row_index),
          first_antenna.char_index + (first_antenna.char_index - second_antenna.char_index)
        ]
      end

      def valid_antinode_location?(row_index, char_index)
        (row_index >= 0 && row_index <= height - 1) && (char_index >= 0 && char_index <= width - 1)
      end

      def antinode_locations(first_antenna, second_antenna)
        return [] unless at_two_different_locations?(first_antenna, second_antenna)

        [
          reflection_location(first_antenna, second_antenna),
          reflection_location(second_antenna, first_antenna)
        ].each_with_object([]) do |arr, r|
          row_index, char_index = arr
          r << "#{row_index},#{char_index}" if valid_antinode_location?(row_index, char_index)
          r
        end
      end

      def antinode_locations_under_resonant_harmonics_effect(first_antenna, second_antenna)
        mirror = Year2024::Day8::Antenna.new(first_antenna.frequency.dup, first_antenna.row_index, first_antenna.char_index)
        target = Year2024::Day8::Antenna.new(second_antenna.frequency.dup, second_antenna.row_index, second_antenna.char_index)
        r = []

        while !target.nil? && at_two_different_locations?(mirror, target) && valid_antinode_location?(target.row_index, target.char_index)
          row_index, char_index = reflection_location(mirror, target)
          r << "#{row_index},#{char_index}" if valid_antinode_location?(row_index, char_index)

          target.row_index = mirror.row_index
          target.char_index = mirror.char_index
          mirror.row_index = row_index
          mirror.char_index = char_index
        end

        mirror = Year2024::Day8::Antenna.new(second_antenna.frequency.dup, second_antenna.row_index, second_antenna.char_index)
        target = Year2024::Day8::Antenna.new(first_antenna.frequency.dup, first_antenna.row_index, first_antenna.char_index)

        while !target.nil? && at_two_different_locations?(mirror, target) && valid_antinode_location?(target.row_index, target.char_index)
          row_index, char_index = reflection_location(mirror, target)
          r << "#{row_index},#{char_index}" if valid_antinode_location?(row_index, char_index)

          target.row_index = mirror.row_index
          target.char_index = mirror.char_index
          mirror.row_index = row_index
          mirror.char_index = char_index
        end

        if at_two_different_locations?(first_antenna, second_antenna)
          r << "#{first_antenna.row_index},#{first_antenna.char_index}"
          r << "#{second_antenna.row_index},#{second_antenna.char_index}"
        end

        r
      end

      def at_two_different_locations?(first_antenna, second_antenna)
        first_antenna.row_index != second_antenna.row_index || first_antenna.char_index != second_antenna.char_index
      end
    end
  end
end
