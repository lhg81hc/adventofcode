module Day10
  class Component
    KNOWN_TYPES = %w(| - L J 7 F . S).freeze
    KNOWN_PIPE_TYPES = %w(| - L J 7 F).freeze

    Pole = Struct.new(:axis, :value)

    attr_reader :char, :location
    attr_accessor :adjacent_components

    def initialize(char, location)
      @char = validate_input_char(char)
      @location = location

      @adjacent_components = []
    end

    def ground?
      component_type == :ground
    end

    def pipe?
      component_type == :pipe
    end

    def starting_point?
      component_type == :starting_point
    end

    def component_type
      @component_type ||=
        begin
          if char == '.'
            :ground
          elsif char == 'S'
            :starting_point
          elsif KNOWN_PIPE_TYPES.include?(char)
            :pipe
          else
            "Unknown type '#{char}'"
          end
        end
    end

    def validate_input_char(c)
      KNOWN_TYPES.include?(c) ? c : raise("Unknown type '#{c}'")
    end

    def poles
      @poles ||=
        case char
        when '|'
          return [Pole.new('y', 1), Pole.new('y', -1)]
        when '-'
          return [Pole.new('x', 1), Pole.new('x', -1)]
        when 'L'
          return [Pole.new('x', 1), Pole.new('y', 1)]
        when 'J'
          return [Pole.new('x', -1), Pole.new('y', 1)]
        when '7'
          return [Pole.new('x', -1), Pole.new('y', -1)]
        when 'F'
          return [Pole.new('x', 1), Pole.new('y', -1)]
        when '.'
          return []
        when 'S'
          return [Pole.new('x', -1), Pole.new('x', 1), Pole.new('y', -1), Pole.new('y', 1)]
        else
          raise "Unknown type '#{char}'"
        end
    end

    def can_connect?(other_component)
      raise 'Current pole can not be nil' if current_pole.nil?

      other_component.poles.any? do |other_pole|
        other_pole.axis == current_pole.axis &&
          (other_pole.value + current_pole.value).zero?
      end
    end
  end
end