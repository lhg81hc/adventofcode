module Year2022
  module Day3
    class SupplyItem
      attr_reader :type

      LOWERCASE_ORDINAL_MIN = 'a'.ord
      LOWERCASE_ORDINAL_MAX = 'z'.ord

      UPPERCASE_ORDINAL_MIN = 'A'.ord
      UPPERCASE_ORDINAL_MAX = 'Z'.ord

      def initialize(type)
        @type = type
      end

      def priority
        return type_ordinal - LOWERCASE_ORDINAL_MIN + 1 if lowercase?
        return type_ordinal - UPPERCASE_ORDINAL_MIN + 1 + 26 if uppercase?

        raise ArgumentError, "Unknown type: #{type}"
      end

      def type_ordinal
        @type_ordinal ||= type.ord
      end

      def lowercase?
        type_ordinal.between?(LOWERCASE_ORDINAL_MIN, LOWERCASE_ORDINAL_MAX)
      end

      def uppercase?
        type_ordinal.between?(UPPERCASE_ORDINAL_MIN, UPPERCASE_ORDINAL_MAX)
      end
    end
  end
end
