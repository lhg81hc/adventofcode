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
          File.open(filepath).each do |line|
            puts "== #{line.strip} =="

            parse_line(line)
            # p tail_history.keys.count
          end
        end

        def parse_line(line)
          parts = line.strip.split(' ')
          direction = parts[0]
          number_of_steps = parts[1].to_i

          number_of_steps.times do
            move_rope(direction)
            put_grid
          end
        end

        def move_rope(direction)
          rope.move(direction)
          tail_history[rope.tail.location.to_s] = true
        end

        def tail_history
          @tail_history ||= { rope.tail.location.to_s => true }
        end

        def rope
          @rope ||=
            begin
              r = Year2022::Day9::Rope.new(Year2022::Day9::Knot.new(0, 0, 'H'))
              (1..2).each { |i| r.append_knot(Year2022::Day9::Knot.new(0, 0, i)) }
              r
            end
        end

        def put_grid
          15.downto(0).each do |line_index|
            (0..22).each do |char_index|
              found_knot = rope.find_knot_by_location([char_index, line_index])

              if found_knot
                print found_knot.ordinal_number
              elsif line_index.zero? && char_index.zero?
                print 's'
              else
                print '.'
              end
            end

            puts "\n"
          end

          puts "\n"
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
