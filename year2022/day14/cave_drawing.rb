module Year2022
  module Day14
    module CaveDrawing
      def draw
        raise StandardError, "Can not draw until scanned" unless scanned?

        (0..max_y).each { |y| puts horizontal_line(y) }
      end

      def horizontal_line(line_idx)
        char = self.class::AIR_CHAR

        if two_dimensional_vertical_slice[line_idx].nil?
          width = (max_x + 1) - (min_x - 1) + 1
          char = self.class::ROCK_CHAR if line_idx == max_y && floor

          char * width
        else
          ((min_x - 1)..(max_x + 1)).map { |char_idx| two_dimensional_vertical_slice[line_idx][char_idx] || char }.join
        end
      end
    end
  end
end
