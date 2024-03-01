require_relative '../platform_panel'
require_relative '../platform_panel_controller'
require_relative '../repeating_pattern_finder'

module Day14
  module Part2
    class Answer
      INPUT_FILE = '../input.txt'

      def self.run
        new.run
      end

      # 87, 69, 69, 69, 65, 64, 65, 63, 68, 69, 69, 65, 64, 65, 63, 68, 69, 69, 65, 64, 65, 63, 68, 69, 69, 65, 64, 65, 63, 68, ...
      #
      # Idea:
      # +) Step 1: Find the repeating pattern
      # +) Step 2: Find the offset of first repeating pattern. Eg: above is 3 (87, 69, 69)
      # +) Step 3: Count the length of duplication pattern. Eg: above is 7 (69, 65, 64, 65, 63, 68, 69)
      # +) Step 4: the formula to calculate last sum of load: (number_of_spins - offset) % length_of_duplication_pattern
      def run
        loads = []
        repeating_pattern_first_idx = nil
        repeating_pattern_length = nil

        1.upto(1000000000).each do |n|
          platform_panel_controller.spin!

          puts "After #{n} cycle:"
          sum = 0

          platform_panel.rows.each do |row|
            row.each do |component|
              next unless component.rounded_rock?
              sum += platform_panel.height - component.position.y
            end
          end

          loads << sum
          puts "[#{loads.join(', ')}]"
          puts "\n"

          repeating_pattern_first_idx, repeating_pattern_length = Day14::RepeatingPatternFinder.new(loads).find

          if repeating_pattern_first_idx
            puts "Found repeating pattern after #{n} cycles!!!"
            break
          end
        end

        final_load_idx = ((1000000000 - repeating_pattern_first_idx) % repeating_pattern_length) + repeating_pattern_first_idx - 1
        puts "After 1000000000 spins, the total load on the north support beams is #{loads[final_load_idx]}"
      end

      def platform_panel
        @platform_panel ||= Day14::PlatformPanel.new(lines)
      end

      def platform_panel_controller
        @platform_panel_controller ||= Day14::PlatformPanelController.new(platform_panel)
      end

      def lines
        @lines ||=
          File.open(input_path).inject([]) do |r, line|
            r << line.strip
            r
          end
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
