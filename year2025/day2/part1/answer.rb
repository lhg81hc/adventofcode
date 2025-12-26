require_relative '../rotation'
require_relative '../dial'

module Year2025
  module Day1
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          dial = Year2025::Day1::Dial.new

          File.foreach(input_filepath).each do |line|
            rotation = Year2025::Day1::Rotation.new(line)
            dial.rotate(rotation)

            puts "#{line.strip} --> current: #{dial.current_position}"
          end

          puts "The actual password to open the door: #{dial.password}"
        end

        def input_filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
