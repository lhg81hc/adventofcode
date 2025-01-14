module Year2024
  module Day8
    class Antenna
      attr_reader :frequency, :row_index, :char_index

      def initialize(frequency, row_index, char_index)
        @frequency = frequency
        @row_index = row_index
        @char_index = char_index
      end
    end
  end
end
