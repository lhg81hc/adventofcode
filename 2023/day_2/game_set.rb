require_relative 'cube'

module Day2
  class GameSet
    BLUE = 'blue'.freeze
    GREEN = 'green'.freeze
    RED = 'red'.freeze

    attr_reader :str

    def initialize(str)
      @str = str
    end

    def cubes
      @cubes ||=
        begin
          s =
            str.split(', ').map do |sub_str|
              color = sub_str.match(/(red|green|blue)/)[1]
              number_of_cubes = sub_str.match(/\d/).string.to_i

              Array.new(number_of_cubes, Day2::Cube.new(color))
            end

          s.flatten
        end
    end

    def total_blue_cubes
      @total_blue_cubes ||= number_of_cubes_by_color(BLUE)
    end

    def total_green_cubes
      @total_green_cubes ||= number_of_cubes_by_color(GREEN)
    end

    def total_red_cubes
      @total_red_cubes ||= number_of_cubes_by_color(RED)
    end

    def number_of_cubes_by_color(color)
      cubes.inject(0) do |count, cube|
        count += 1 if cube.color == color
        count
      end
    end
  end
end
