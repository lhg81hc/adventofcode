module Year2025
  module Day2
    class ProductIdRanges
      attr_reader :str, :first_id, :last_id

      def initialize(str)
        @str = str
        @raw = str.strip
        parse!
      end

      def invalid_ids
        []
      end

      def parse!
        parts = @raw.split('-')

        @first_id = parts[0]&.to_i
        @last_id = parts[1]&.to_i
      end
    end
  end
end
