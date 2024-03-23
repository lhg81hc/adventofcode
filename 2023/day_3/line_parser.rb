require_relative 'schematic_character'

module Day3
  class LineParser
    NUMBER_CHARS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].freeze

    attr_reader :lines

    ParsedNumber = Struct.new(:number_chars, :integer_value, :adjacent_chars)

    def initialize(lines)
      @lines = lines
    end

    def numbers
      @numbers ||=
        begin
          number_chars = []
          last_idx = curr_line_value.length - 1

          curr_line_value.each_char.with_index.inject([]) do |r, (char, char_idx)|
            is_number_char = NUMBER_CHARS.include?(char)

            number_chars << char if is_number_char

            if !is_number_char || (char_idx == last_idx && is_number_char)
              length = number_chars.length

              unless length.zero?
                start_idx = char_idx - length
                start_idx += 1 if char_idx == last_idx && is_number_char

                number_chars_list = number_chars.map.with_index { |c, c_idx| Day3::SchematicCharacter.new(c, curr_line_index, start_idx + c_idx) }
                number = ParsedNumber.new(number_chars_list, number_chars.join.to_i, adjacent_chars(start_idx, length))

                r << number
                number_chars.clear
              end
            end

            r
          end
        end
    end

    def adjacent_chars(start_index, length)
      # Clockwise starting from top left
      top_adjacent_chars(start_index, length) +
        [right_adjacent_char(start_index, length)] +
        bottom_adjacent_chars(start_index, length) +
        [left_adjacent_char(start_index)]
    end

    def top_left_adjacent_char(start_index)
      return nil if prev_line_nil? || start_index.zero?

      Day3::SchematicCharacter.new(prev_line_value[start_index - 1], prev_line_index, start_index - 1)
    end

    def top_right_adjacent_char(start_index, length)
      return nil if prev_line_nil? || prev_line_value[start_index + length].nil?

      Day3::SchematicCharacter.new(prev_line_value[start_index + length], prev_line_index, start_index + length)
    end

    def top_adjacent_chars(start_index, length)
      chars = [top_left_adjacent_char(start_index)]

      if prev_line_nil?
        chars += Array.new(length, nil)
      else
        chars += (0..(length - 1)).map { |c| Day3::SchematicCharacter.new(prev_line_value[start_index + c], prev_line_index, start_index + c) }
      end

      chars << top_right_adjacent_char(start_index, length)
      chars
    end

    def right_adjacent_char(start_index, length)
      return nil if curr_line_value[start_index + length].nil?

      Day3::SchematicCharacter.new(curr_line_value[start_index + length], curr_line_index, start_index + length)
    end

    def bottom_right_adjacent_char(start_index, length)
      return nil if next_line_nil? || next_line_value[start_index + length].nil?

      Day3::SchematicCharacter.new(next_line_value[start_index + length], next_line_index, start_index + length)
    end

    def bottom_left_adjacent_char(start_index)
      return nil if next_line_nil? || start_index.zero?

      Day3::SchematicCharacter.new(next_line_value[start_index - 1], next_line_index, start_index - 1)
    end

    def bottom_adjacent_chars(start_index, length)
      chars = [bottom_right_adjacent_char(start_index, length)]

      if next_line_nil?
        chars += Array.new(length, nil)
      else
        chars += (length - 1).downto(0).map { |c| Day3::SchematicCharacter.new(next_line_value[start_index + c], next_line_index, start_index + c) }
      end

      chars << bottom_left_adjacent_char(start_index)
      chars
    end

    def left_adjacent_char(start_index)
      return nil if start_index.zero?

      Day3::SchematicCharacter.new(curr_line_value[start_index - 1], curr_line_index, start_index - 1)
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

    def prev_line_nil?
      prev_line.nil?
    end

    def next_line_nil?
      next_line.nil?
    end
  end
end
