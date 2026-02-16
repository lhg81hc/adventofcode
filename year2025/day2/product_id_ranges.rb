module Year2025
  module Day2
    class ProductIdRanges
      attr_reader :str, :first_id, :last_id

      def initialize(str)
        @str = str
        @raw = str.strip
        parse!
      end

      def mirrored_ids
        results = []

        prefix = starting_prefix
        invalid_id = mirrored_id(prefix)

        while invalid_id <= last_id
          results << invalid_id if invalid_id >= first_id

          prefix += 1
          invalid_id = mirrored_id(prefix)
        end

        results
      end

      def repeated_ids
        results = []
        current_id = first_id

        while current_id <= last_id
          results << current_id if repeated_sequence?(current_id)

          current_id += 1
        end

        results
      end

      private

      def repeated_sequence?(id)
        str = id.to_s
        length = str.length

        return false if length <= 1

        (1..(length / 2)).each do |pattern_length|
          next unless (length % pattern_length).zero?

          pattern = str[0, pattern_length]
          return true if pattern * (length / pattern_length) == str
        end

        false
      end

      def starting_prefix
        number_of_digits = Math.log10(first_id).floor + 1
        half_of_digits = number_of_digits / 2

        return 1 if half_of_digits.zero?
        return first_id / (10 ** half_of_digits) if number_of_digits.even?

        first_id / (10 ** (half_of_digits + 1))
      end

      def mirrored_id(prefix)
        number_of_digits = Math.log10(prefix).floor + 1

        prefix * (10 ** number_of_digits) + prefix
      end

      def parse!
        parts = @raw.split('-')

        @first_id = parts[0]&.to_i
        @last_id = parts[1]&.to_i
      end
    end
  end
end
