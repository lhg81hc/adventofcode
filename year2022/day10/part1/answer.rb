require_relative '../instruction'
require_relative '../instruction_list'

module Year2022
  module Day10
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          sum =
            [20, 60, 100, 140, 180, 220].inject(0) do |s, num_of_cycles|
              s += num_of_cycles * instruction_list.addx_values_after_n_cycles(num_of_cycles).sum
              s
            end


          puts "The sum of six signal strengths (at 20th, 60th, 100th, 140th, 180th, and 220th cycles) is: #{sum}"
        end

        def instruction_list
          @instruction_list ||=
            begin
              r = Year2022::Day10::InstructionList.new
              File.foreach(input_path) { |line| r.add_instruction(Year2022::Day10::Instruction.new(*parse_line(line))) }
              r
            end
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
