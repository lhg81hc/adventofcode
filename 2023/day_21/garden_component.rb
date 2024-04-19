module Day21
  class GardenComponent
    ROCK = :rock
    GARDEN_PLOT = :garden_plot
    STARTING_POSITION = :starting_position

    attr_reader :char, :line_idx, :char_idx, :adjacent_components

    def initialize(char, line_idx, char_idx, adjacent_components = [])
      @char = char
      @line_idx = line_idx
      @char_idx = char_idx
      @adjacent_components = adjacent_components
    end

    def add_adjacent_component(component)
      @adjacent_components << component
    end

    def stepable_adjacent_components
      @adjacent_components.select { |c| !c.rock? }
    end

    def location
      "#{line_idx},#{char_idx}"
    end

    def type
      case char
      when '#'
        ROCK
      when '.'
        GARDEN_PLOT
      when 'S'
        STARTING_POSITION
      else
        raise "Unknown character #{char}"
      end
    end

    def rock?
      type == ROCK
    end

    def garden_plot?
      type == GARDEN_PLOT
    end

    def starting_position
      type == STARTING_POSITION
    end
  end
end
