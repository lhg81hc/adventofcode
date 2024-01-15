module Day1
  module Part1
    class LineParser
      NUMBER_SELECTORS = "^0-9"

      attr_reader :value

      def initialize(value)
        @value = value
      end

      def numbers_only_str
        @numbers_only_str ||= value.delete(NUMBER_SELECTORS)
      end

      def first_found_number
        numbers_only_str[0]
      end

      def last_found_number
        numbers_only_str[-1]
      end

      def calibration_value
        ((first_found_number || 0).to_i * 10) + (last_found_number || 0).to_i
      end

      def output
        [
          value.strip,
          calibration_value
        ].join(' --> ')
      end
    end
  end
end
