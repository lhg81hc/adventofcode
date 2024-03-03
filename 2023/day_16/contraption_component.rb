module Day16
  class ContraptionComponent
    UP = 'up'.freeze
    DOWN = 'down'.freeze
    LEFT = 'left'.freeze
    RIGHT = 'right'.freeze
    DIRECTIONS = [UP, DOWN, LEFT, RIGHT].freeze

    EMPTY_SPACE_DEPARTING_DIRECTIONS = {
      UP => [UP],
      DOWN => [DOWN],
      LEFT => [LEFT],
      RIGHT => [RIGHT],
    }

    LEFT_TILTED_MIRROR_DEPARTING_DIRECTIONS = {
      UP => [LEFT],
      DOWN => [RIGHT],
      LEFT => [UP],
      RIGHT => [DOWN],
    }

    RIGHT_TILTED_MIRROR_DEPARTING_DIRECTIONS = {
      UP => [RIGHT],
      DOWN => [LEFT],
      LEFT => [DOWN],
      RIGHT => [UP],
    }

    HORIZONTAL_SPLITTER_DEPARTING_DIRECTIONS = {
      UP => [LEFT, RIGHT],
      DOWN => [LEFT, RIGHT],
      LEFT => [LEFT],
      RIGHT => [RIGHT],
    }

    VERTICAL_SPLITTER_DEPARTING_DIRECTIONS = {
      UP => [UP],
      DOWN => [DOWN],
      LEFT => [UP, DOWN],
      RIGHT => [UP, DOWN],
    }

    attr_reader :location, :char

    def initialize(location, char)
      @location = location
      @char = char
    end

    def type
      case char
      when '.'
        :empty_space
      when '\\'
        :left_tilted_mirror
      when '/'
        :right_tilted_mirror
      when '-'
        :horizontal_splitter
      when '|'
        :vertical_splitter
      else
        raise "Invalid character #{char}"
      end
    end

    def empty_space?
      type == :empty_space
    end

    def mirror?
      type == :left_tilted_mirror || type == :right_tilted_mirror
    end

    def splitter?
      type == :horizontal_splitter || type == :vertical_splitter
    end

    def departing_directions(arriving_direction)
      raise "Invalid arriving direction #{arriving_direction}" unless DIRECTIONS.include?(arriving_direction)

      case type
      when :empty_space
        return EMPTY_SPACE_DEPARTING_DIRECTIONS[arriving_direction]
      when :left_tilted_mirror
        return LEFT_TILTED_MIRROR_DEPARTING_DIRECTIONS[arriving_direction]
      when :right_tilted_mirror
        return RIGHT_TILTED_MIRROR_DEPARTING_DIRECTIONS[arriving_direction]
      when :horizontal_splitter
        return HORIZONTAL_SPLITTER_DEPARTING_DIRECTIONS[arriving_direction]
      when :vertical_splitter
        return VERTICAL_SPLITTER_DEPARTING_DIRECTIONS[arriving_direction]
      end
    end
  end
end
