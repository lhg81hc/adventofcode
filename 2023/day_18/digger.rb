module Day18
  class Digger
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def dig
      start_position_y = 0
      start_position_x = 0

      lines.map do |line|
        direction, num_of_meters = line_parser(line)

        trench = dig_by_direction(start_position_x, start_position_y, direction, num_of_meters)
        start_position_x, start_position_y = trench[-1]

        trench
      end
    end

    def line_parser(line)
      parts = line.split
      direction = parts[0]
      num_of_meters = parts[1].to_i

      [direction, num_of_meters]
    end

    def dig_by_direction(start_position_x, start_position_y, direction, num_of_meters)
      case direction
      when 'R'
        (start_position_x + 1).upto(start_position_x + num_of_meters).map { |n| [n, start_position_y] }
      when 'L'
        (start_position_x - 1).downto(start_position_x - num_of_meters).map { |n| [n, start_position_y] }
      when 'U'
        (start_position_y - 1).downto(start_position_y - num_of_meters).map { |n| [start_position_x, n] }
      when 'D'
        (start_position_y + 1).upto(start_position_y + num_of_meters).map { |n| [start_position_x, n] }
      else
        raise "Invalid direction #{direction}"
      end
    end
  end
end
