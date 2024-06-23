require_relative '../instruction'

module Year2022
  module Day10
    module Part1
      class Answer

        def initialize
          @final_num_of_cycles = 220
        end

        def self.run
          new.run
        end

        def run
          i = 0
          sum_of_values = 1
          sum_of_signal_strengths = 0

          while i < @final_num_of_cycles do
            instruction_list.each do |instruction|
              break if i >= @final_num_of_cycles

              instruction.number_of_required_cycles.times do
                i += 1

                if (i % 40) == 20
                  puts "During the #{i}th cycle, register X has the value #{sum_of_values}, " +
                       "so the signal strength is #{i} * #{sum_of_values} = #{i * sum_of_values}."
                  sum_of_signal_strengths += i * sum_of_values
                end
              end

              sum_of_values += instruction.value
            end
          end

          puts "Sum of these six signal strengths (20th, 60th, 100th, 140th, 180th, and 220th cycles): #{sum_of_signal_strengths}"
        end

        def instruction_list
          @instruction_list ||=
            File.foreach(input_path).inject([]) { |r, line| r << Year2022::Day10::Instruction.new(*parse_line(line)) }
        end

        def parse_line(line)
          parts = line.strip.split(' ')
          instruction_name, instruction_value = parts

          [instruction_name, instruction_value.to_i]
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
