module Year2024
  module Day1
    class ListParser
      attr_reader :input_path

      def initialize(input_path)
        @input_path = input_path
      end

      def parse
        File.foreach(input_path).inject([]) do |r, line|
          if r.empty?
            r << []
            r << []
          end

          nums = parse_line(line)

          r[0] << nums[0]
          r[1] << nums[1]

          r
        end
      end

      def parse_line(line)
        line.split.map(&:to_i)
      end
    end
  end
end