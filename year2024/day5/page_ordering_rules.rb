module Year2024
  module Day5
    class PageOrderingRules
      attr_reader :input_path

      def initialize(input_path)
        @input_path = input_path
      end

      def rules
        @rules ||=
          File.foreach(input_path).each_with_object({}) do |line, r|
            stripped_line = line.strip
            next unless stripped_line.match(/\d+\|\d+/)

            first_number, second_number = stripped_line.split('|')

            r[stripped_line] ||= 1
            r["#{second_number}|#{first_number}"] ||= -1
          end
      end

      def order(first_number, second_number)
        key = "#{first_number}|#{second_number}"

        return 0 if rules[key].nil?

        rules[key]
      end

      def right_order?(first_number, second_number)
        order(first_number, second_number).positive?
      end
    end
  end
end
