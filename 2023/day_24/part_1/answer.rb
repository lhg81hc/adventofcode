require_relative '../input_parser'
require_relative '../testing_area'

module Day24
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        num_of_hailstones = hailstones.length

        t =
          hailstones.each.with_index.inject(0) do |r, (hailstone, i)|
            (i + 1).upto(num_of_hailstones - 1) do |j|
              another_hailstone = hailstones[j]
              coordinates = hailstone.coordinates_of_intersection(another_hailstone)

              if !coordinates.nil?
                x_coordinate, y_coordinate = coordinates

                if x_coordinate.nil?
                  puts "Hailstones '#{hailstone.name}' & '#{another_hailstone.name}' paths crossed in the past."
                else

                  if testing_area.include?([x_coordinate, y_coordinate])
                    puts "Hailstones '#{hailstone.name}' & '#{another_hailstone.name}' paths will cross INSIDE the test area (at x=#{x_coordinate.to_f}, y=#{y_coordinate.to_f})."
                    r += 1
                  else
                    puts "Hailstones '#{hailstone.name}' & '#{another_hailstone.name}' paths will cross OUTSIDE the test area (at x=#{x_coordinate.to_f}, y=#{y_coordinate.to_f})."
                  end
                end
              else
                puts "Hailstones '#{hailstone.name}' & '#{another_hailstone.name} are parallel; they never intersect."
              end
            end

            r
          end

        puts "\n"
        puts "The number of intersections occur within the test area: #{t}"
      end

      def hailstones
        @hailstones ||= Day24::InputParser.parse(filepath)
      end

      def testing_area
        @testing_area ||= Day24::TestingArea.new(200000000000000, 400000000000000)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
