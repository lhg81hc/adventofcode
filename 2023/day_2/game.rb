require_relative 'game_set'

module Day2
  class Game
    VALID_NO_OF_BLUE = 14
    VALID_NO_OF_GREEN = 13
    VALID_NO_OF_RED = 12

    attr_reader :str

    def initialize(str)
      @str = str
    end

    def id
      @id ||= str.match(/(?<=Game )(.*)(?=:)/)[1].to_i
    end

    def str_of_all_game_sets
      @str_of_all_game_sets ||= str.match(/(?<=: )(.*)/)[1]
    end

    def arr_of_game_set_str
      @arr_of_game_set_str ||= str_of_all_game_sets.split(';')
    end

    def game_sets
      @game_sets ||= arr_of_game_set_str.map { |game_set_str| Day2::GameSet.new(game_set_str.strip) }
    end

    def possible?
      game_sets.all? do |gs|
        gs.total_blue_cubes <= VALID_NO_OF_BLUE &&
          gs.total_green_cubes <= VALID_NO_OF_GREEN &&
          gs.total_red_cubes <= VALID_NO_OF_RED
      end
    end

    def fewest_num_of_possible_blue_cubes
      @fewest_num_of_blue_cubes ||= game_sets.map(&:total_blue_cubes).select(&:positive?).max
    end

    def fewest_num_of_possible_green_cubes
      @fewest_num_of_possible_green_cubes ||= game_sets.map(&:total_green_cubes).select(&:positive?).max
    end

    def fewest_num_of_possible_red_cubes
      @fewest_num_of_possible_red_cubes ||= game_sets.map(&:total_red_cubes).select(&:positive?).max
    end

    def the_power_of_the_set_of_cubes
      fewest_num_of_possible_blue_cubes * fewest_num_of_possible_green_cubes * fewest_num_of_possible_red_cubes
    end
  end
end
