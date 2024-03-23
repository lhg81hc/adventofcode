module Day3
  class SchematicCharacter
    attr_reader :value, :line_index, :char_index

    def initialize(value, line_index, char_index)
      @value = value
      @line_index = line_index
      @char_index = char_index
    end
  end
end
