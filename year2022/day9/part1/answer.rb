require_relative '../rope'
require_relative '../knot'

module Year2022
  module Day9
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          File.open(filepath).each do |line|
            direction, number_of_steps = parse_line(line)
            move_rope(number_of_steps, direction)

            puts "== #{line.strip} =="
            puts tail_history.keys.count
            puts "\n"
          end
        end

        def parse_line(line)
          parts = line.strip.split(' ')
          [parts[0], parts[1].to_i]
        end

        def move_rope(number_of_steps, direction)
          number_of_steps.times do
            rope.move(direction)
            tail_history[rope.tail.location.to_s] = true
          end
        end

        def tail_history
          @tail_history ||= { rope.tail.location.to_s => true }
        end

        def rope
          @rope ||= Year2022::Day9::Rope.new([head, tail])
        end

        def head
          Year2022::Day9::Knot.new(0, 0, 'head')
        end

        def tail
          Year2022::Day9::Knot.new(0, 0, 'tail')
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
