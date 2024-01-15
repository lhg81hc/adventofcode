require_relative '../part_1/line_parser'

module Day1
  module Part2
    class LineParser < Day1::Part1::LineParser
      NUMBER_AS_LETTERS = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
      NUMBER_AS_DIGIT = ['1', '2', '3', '4', '5', '6', '7', '8', '9']

      def indices_of_sub_string(sub_str)
        (0 ... @value.length).find_all { |i| @value[i, sub_str.length] == sub_str }
      end

      def map_of_sub_string_indices(sub_str_arr)
        sub_str_arr.inject({}) do |h, s|
          h[s] = indices_of_sub_string(s)
          h
        end
      end

      def map_of_number_as_digit
        # Eg: {"1"=>[], "2"=>[], "3"=>[], "4"=>[], "5"=>[3], "6"=>[], "7"=>[], "8"=>[], "9"=>[]}
        @map_of_number_as_digit ||= map_of_sub_string_indices(NUMBER_AS_DIGIT)
      end

      def first_number_as_digit
        @first_number_as_digit ||=
          begin
            value = nil
            index = nil
            map_of_number_as_digit.each do |k, v|
              next if v.length.zero?

              if value.nil?
                value = k.to_i
                index = v.min
                next
              end

              if index > v.min
                value = k.to_i
                index = v.min
              end
            end

            { 'value' => value, 'index' => index }
          end
      end

      def last_number_as_digit
        @last_number_as_digit ||=
          begin
            value = nil
            index = nil
            map_of_number_as_digit.each do |k, v|
              next if v.length.zero?

              if value.nil?
                value = k.to_i
                index = v.max
                next
              end

              if index < v.max
                value = k.to_i
                index = v.max
              end
            end

            { 'value' => value, 'index' => index }
          end
      end

      def map_of_number_as_letters
        # Eg: {"one"=>[], "two"=>[], "three"=>[], "four"=>[], "five"=>[], "six"=>[0], "seven"=>[], "eight"=>[], "nine"=>[]}
        @map_of_number_as_letters ||= map_of_sub_string_indices(NUMBER_AS_LETTERS)
      end

      def first_number_as_letters
        @first_number_as_letters ||=
          begin
            value = nil
            index = nil
            map_of_number_as_letters.each do |k, v|
              next if v.length.zero?

              if value.nil?
                value = NUMBER_AS_LETTERS.index(k) + 1
                index = v.min
                next
              end

              if index > v.min
                value = NUMBER_AS_LETTERS.index(k) + 1
                index = v.min
              end
            end

            { 'value' => value, 'index' => index }
          end
      end

      def last_number_as_letters
        @last_number_as_letters ||=
          begin
            value = nil
            index = nil
            map_of_number_as_letters.each do |k, v|
              next if v.length.zero?

              if value.nil?
                value = NUMBER_AS_LETTERS.index(k) + 1
                index = v.max
                next
              end

              if index < v.max
                value = NUMBER_AS_LETTERS.index(k) + 1
                index = v.max
              end
            end

            { 'value' => value, 'index' => index }
          end
      end

      def first_found_number
        if first_number_as_digit['index'].nil?
          return first_number_as_letters['value']
        end

        if first_number_as_letters['index'].nil?
          return first_number_as_digit['value']
        end

        if first_number_as_digit['index'] < first_number_as_letters['index']
          first_number_as_digit['value']
        else
          first_number_as_letters['value']
        end
      end

      def last_found_number
        if last_number_as_digit['index'].nil?
          return last_number_as_letters['value']
        end

        if last_number_as_letters['index'].nil?
          return last_number_as_digit['value']
        end

        if last_number_as_digit['index'] > last_number_as_letters['index']
          last_number_as_digit['value']
        else
          last_number_as_letters['value']
        end
      end
    end
  end
end
