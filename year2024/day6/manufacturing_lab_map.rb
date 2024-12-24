module Year2024
  module Day6
    class ManufacturingLabMap
      UP_CHAR = '^'.freeze
      DOWN_CHAR = 'v'.freeze
      RIGHT_CHAR = '>'.freeze
      LEFT_CHAR = '<'.freeze

      DIRECTION_BY_CHARACTER_MAP = {
        UP_CHAR => :up,
        RIGHT_CHAR => :right,
        DOWN_CHAR => :down,
        LEFT_CHAR => :left
      }.freeze

      attr_reader :input_path, :current_guard_direction, :current_guard_position, :two_d_map

      def initialize(input_path)
        @input_path = input_path
        @scanned = false
        @two_d_map = []
        @current_guard_position = nil
        @current_guard_direction = nil
      end

      def scanned?
        @scanned
      end

      def scan
        File.foreach(input_path).with_index { |line, line_idx| scan_line(line, line_idx) }

        @scanned = true
      end

      def scan_line(line, line_idx)
        chars = line.chars

        if @current_guard_position.nil? && @current_guard_direction.nil?
          chars.each.with_index do |char, char_idx|
            next unless [UP_CHAR, DOWN_CHAR, LEFT_CHAR, RIGHT_CHAR].include?(char)

            @current_guard_direction = DIRECTION_BY_CHARACTER_MAP[char]
            @current_guard_position = [line_idx, char_idx]
            chars[char_idx] = '.'
          end
        end

        @two_d_map << chars
      end
    end
  end
end
