require_relative 'city_block'

module Day17
  class LineParser
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def city_blocks
      @city_blocks ||=
        curr_line_value.each_char.with_index.inject([]) do |r, (char, char_idx)|
          r << Day17::CityBlock.new(curr_line_index, char_idx, char.to_i, adjacent_city_blocks(char_idx))
          r
        end
    end

    def adjacent_city_blocks(curr_index)
      # Clockwise starting from top
      [
        top_adjacent_city_block(curr_index),
        right_adjacent_city_block(curr_index),
        bottom_adjacent_city_block(curr_index),
        left_adjacent_city_block(curr_index)
      ]
    end

    def top_adjacent_city_block(curr_index)
      prev_line.nil? ? nil : prev_line_value[curr_index]
    end

    def right_adjacent_city_block(curr_index)
      curr_index == last_index ? nil : curr_line_value[curr_index + 1]
    end

    def bottom_adjacent_city_block(curr_index)
      next_line.nil? ? nil : next_line_value[curr_index]
    end

    def left_adjacent_city_block(curr_index)
      curr_index.zero? ? nil : curr_line_value[curr_index - 1]
    end

    def prev_line
      lines[0]
    end

    def curr_line
      lines[1]
    end

    def next_line
      lines[2]
    end

    def prev_line_index
      prev_line&.index
    end

    def prev_line_value
      prev_line&.value
    end

    def curr_line_index
      curr_line.index
    end

    def curr_line_value
      curr_line.value
    end

    def curr_line_length
      curr_line_value.length
    end

    def last_index
      curr_line_length - 1
    end

    def next_line_index
      next_line&.index
    end

    def next_line_value
      next_line&.value
    end
  end
end
