require_relative '../land_scape'

module Day10
  module Part2
    class Answer
      INPUT_FILE = '../input.txt'

      attr_reader :sum

      def initialize
        @sum = 0
      end

      def self.run
        new.run
      end

      def run
        list = []
        land_scape.map.each do |line|
          line.each do |component|
            next unless component.ground?
            if land_scape.position_compare_to_main_loop(component.location).positive?
              @sum +=1
              list << component.location
            end
          end
        end

        puts "sum: #{sum}"
        puts "list: #{list}"
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
