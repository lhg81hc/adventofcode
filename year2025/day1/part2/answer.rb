require_relative '../rotation'
require_relative '../dial'

module Year2025
  module Day1
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          dial = Year2025::Day1::Dial.new

          puts "current: #{dial.current_position}"

          File.foreach(input_filepath).each do |line|
            rotation = Year2025::Day1::Rotation.new(line)
            dial.rotate(rotation)

            puts "rotation: #{line.strip}, current: #{dial.current_position}, password_0x434C49434B: #{dial.password_0x434C49434B}"
          end
        end

        def input_filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
