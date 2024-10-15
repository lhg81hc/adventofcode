module Year2022
  module Day14
    module BresenhamLine
      def plot_line_low(x0, y0, x1, y1)
        p = []
        dx = x1 - x0
        dy = y1 - y0
        yi = 1

        if dy < 0
          yi = -1
          dy = -dy
        end

        d = 2*dy - dx
        y = y0

        (x0..x1).each do |x|
          p << [x, y]

          if d > 0
            y = y + yi
            d = d + 2*(dy - dx)
          else
            d = d + 2*dy
          end
        end

        p
      end

      def plot_line_high(x0, y0, x1, y1)
        p = []
        dx = x1 - x0
        dy = y1 - y0
        xi = 1

        if dx < 0
          xi = -1
          dx = -dx
        end

        d = 2*dx - dy
        x = x0

        (y0..y1).each do |y|
          p << [x, y]

          if d > 0
            x = x + xi
            d = d + 2*(dx - dy)
          else
            d = d + 2*dx
          end
        end

        p
      end

      def plot_line(x0, y0, x1, y1)
        if (y1 - y0).abs < (x1 - x0).abs
          if x0 > x1
            plot_line_low(x1, y1, x0, y0)
          else
            plot_line_low(x0, y0, x1, y1)
          end
        else
          if y0 > y1
            plot_line_high(x1, y1, x0, y0)
          else
            plot_line_high(x0, y0, x1, y1)
          end
        end
      end
    end
  end
end
