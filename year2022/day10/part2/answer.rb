require_relative '../instruction'
require_relative '../cathode_ray_tube_screen'

module Year2022
  module Day10
    module Part2
      class Answer
        def initialize
          @cycle_ordinal_number = 0
        end

        def self.run
          new.run
        end

        def run
          instruction_list.each do |instruction|
            instruction.number_of_required_cycles.times do
              ctr.draw(@cycle_ordinal_number += 1)
            end

            @ctr.update_sprite_position(instruction)
          end

          ctr.print
        end

        def ctr
          @ctr ||= Year2022::Day10::CathodeRayTubeScreen.new
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
