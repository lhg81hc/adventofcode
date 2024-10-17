require_relative 'path_of_rock'
require_relative 'sand'
require_relative 'cave_drawing'

module Year2022
  module Day14
    class Cave
      ROCK_CHAR = '#'
      SAND_CHAR = 'o'
      AIR_CHAR = '.'

      include CaveDrawing

      attr_accessor :input_path, :min_x, :max_x, :min_y, :max_y, :floor, :two_dimensional_vertical_slice

      def initialize(input_path, floor: false)
        @input_path = input_path
        @scanned = false
        @min_x = nil
        @max_x = nil
        @min_y = nil
        @max_y = nil
        @floor = floor
        @two_dimensional_vertical_slice = []
      end

      def scan
        @two_dimensional_vertical_slice = []

        paths_of_rock.each do |path_of_rock|
          path_of_rock.lines_of_rock.each do |line_of_rock|
            line_of_rock.points.each do |arr|
              x = arr[0]
              y = arr[1]

              @min_x = x if @min_x.nil? || @min_x > x
              @max_x = x if @max_x.nil? || @max_x < x
              @min_y = y if @min_y.nil? || @min_y > y
              @max_y = y if @max_y.nil? || @max_y < y

              @two_dimensional_vertical_slice[y] ||= []
              @two_dimensional_vertical_slice[y][x] = ROCK_CHAR
            end
          end
        end

        @max_y += 2 if floor
        @scanned = true

        nil
      end

      def pour_sand
        if floor
          pour_sand_with_floor
        else
          pour_sand_without_floor
        end
      end

      def pour_sand_without_floor
        sand = Year2022::Day14::Sand.new

        loop do
          next_coordinates = sand.next_coordinates.find { |x, y| (two_dimensional_vertical_slice[y].nil? || two_dimensional_vertical_slice[y][x].nil?) && x.between?(min_x, max_x) && y <= max_y }
          sand.coordinates = next_coordinates.dup unless next_coordinates.nil?

          break if next_coordinates.nil?
        end

        if sand.next_coordinates.find { |x, y| (two_dimensional_vertical_slice[y].nil? || two_dimensional_vertical_slice[y][x].nil?) }
          sand.coordinates = [nil, nil]
        else
          @two_dimensional_vertical_slice[sand.y] ||= []
          @two_dimensional_vertical_slice[sand.y][sand.x] = SAND_CHAR
        end

        sand
      end

      def pour_sand_with_floor
        sand = Year2022::Day14::Sand.new

        loop do
          next_coordinates = sand.next_coordinates.find { |x, y| (two_dimensional_vertical_slice[y].nil? || two_dimensional_vertical_slice[y][x].nil?) && y < max_y }
          sand.coordinates = next_coordinates.dup unless next_coordinates.nil?

          break if next_coordinates.nil?
        end

        @min_x = sand.x if @min_x.nil? || @min_x > sand.x
        @max_x = sand.x if @max_x.nil? || @max_x < sand.x

        @two_dimensional_vertical_slice[sand.y] ||= []
        @two_dimensional_vertical_slice[sand.y][sand.x] = SAND_CHAR

        sand
      end

      def scanned?
        @scanned
      end

      def paths_of_rock
        @paths_of_rock ||= File.foreach(input_path).map { |line| Year2022::Day14::PathOfRock.new(line) }
      end
    end
  end
end
