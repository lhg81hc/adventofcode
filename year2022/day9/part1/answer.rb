require_relative '../rope'
require_relative '../rope_knot'

module Year2022
  module Day9
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          File.open(filepath).each do |line|
            parse_line(line)
            puts "== #{line.strip} =="
            puts tail_history.keys.count
          end
        end

        def parse_line(line)
          parts = line.strip.split(' ')
          direction = parts[0]
          number_of_steps = parts[1].to_i

          number_of_steps.times do
            rope.move(direction)
            tail_history[rope.tail.to_s] = true
          end
        end

        def tail_history
          @tail_history ||= { rope.tail.to_s => true }
        end

        def rope
          @rope ||=
            begin
              head = Year2022::Day9::RopeKnot.new(0, 0, :head)
              tail = Year2022::Day9::RopeKnot.new(0, 0, :tail)

              Year2022::Day9::Rope.new(head, tail)
            end
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
