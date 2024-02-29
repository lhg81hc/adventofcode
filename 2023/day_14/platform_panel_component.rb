module Day14
  class PlatformPanelComponent
    attr_reader :char

    def initialize(char)
      @char = char
    end

    def type
      case char
      when 'O'
        :rounded_rock
      when '#'
        :cube_shaped_rock
      when '.'
        :space
      else
        raise "Invalid value"
      end
    end

    def rounded_rock?
      type == :rounded_rock
    end

    def cube_shaped_rock?
      type == :cube_shaped_rock
    end

    def space?
      type == :space
    end

    def rock?
      rounded_rock? || cube_shaped_rock?
    end

    def can_roll?
      rounded_rock?
    end
  end
end
