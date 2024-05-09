module Day23
  class MapComponent
    attr_accessor :line_idx, :char_idx, :char

    COMPONENT_TYPES = [
      :path,
      :forest,
      :slope
    ].freeze

    def initialize(line_idx, char_idx, char)
      @line_idx = line_idx
      @char_idx = char_idx
      @char = char
    end

    def type
      case char
      when '.'
        :path
      when '#'
        :forest
      when '^', '>', 'v', '<'
        :slope
      else
        raise ArgumentError, "Invalid component type #{char}"
      end
    end

    def path?
      type == :path
    end

    def forest?
      type == :forest
    end

    def slope?
      type == :slope
    end
  end
end
