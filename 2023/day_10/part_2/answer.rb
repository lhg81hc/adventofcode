require_relative '../land_scape'

module Day10
  module Part2
    class Answer
      INPUT_FILE = '../input.txt'

      def initialize
      end

      def self.run
        new.run
      end

      def run
        # count = 0
        enclose_by_loop = []
        enclose_by_main_loop = []
        s_point = land_scape.s_point

        land_scape.map.each.with_index do |components, idx|
          next unless idx.zero?

          components.each do |component|
            next unless component.ground?

            puts "Checking [#{component.location.join(', ')}]..."
            puts "Finding closest left pipe..."
            closest_left_pipe = land_scape.find_closest_left_pipe(starting_point: component.location)

            if closest_left_pipe
              find_loop = land_scape.find_loop(starting_point: closest_left_pipe)
              if find_loop
                enclose_by_loop << component.location.join(',')
                if find_loop[s_point.join(',')]
                  enclose_by_main_loop << component.location.join(',')
                end

                puts "[#{component.location.join(', ')}] Is in a closed loop!"
                puts find_loop
              else
                puts "Next because closed loop is NOT found"
                puts "--------------------------------------"
              end
            else
              puts "Next because closest pipe is NOT found"
              puts "--------------------------------------"
              next
            end
          end
        end

        puts "Enclosed by loop #{enclose_by_loop.count}: #{enclose_by_loop.map { |point| "[#{point}]"}.join(" | ")}"
        puts "Enclosed by main loop #{enclose_by_main_loop.count}: #{enclose_by_main_loop.map { |point| "[#{point}]"}.join(" | ")}"
      end

      def land_scape
        @land_scape ||= LandScape.new(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
