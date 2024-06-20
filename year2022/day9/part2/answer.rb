require_relative '../rope'
require_relative '../knot'

module Year2022
  module Day9
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          @rope = init_rope
          @tail_history = { @rope.tail.location.to_s => true }

          File.open(filepath).each do |line|
            puts "== #{line.strip} =="
            direction, number_of_steps = parse_line(line)

            number_of_steps.times do
              @rope.move(direction)
              @tail_history[@rope.tail.location.to_s] = true
            end

            p @tail_history.keys.count
            puts "\n"
          end
        end

        def parse_line(line)
          parts = line.strip.split(' ')
          [parts[0], parts[1].to_i]
        end

        def head
          Year2022::Day9::Knot.new(0, 0, 'H')
        end

        def knots
          (1..9).map { |i| Year2022::Day9::Knot.new(0, 0, i.to_s) }
        end

        def init_rope
          r = Year2022::Day9::Rope.new(head)
          knots.each { |knot| r.append_knot(knot) }
          r
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
