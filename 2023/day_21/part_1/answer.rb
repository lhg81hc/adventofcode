require_relative '../garden_map_builder'
require_relative '../garden_plot_counter'

module Day21
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        (1..64).each do |n|
          next unless n == 2 || n >= 4
          reachable_plots_after_n_steps = garden_plot_counter.find_reachable_plots_after_n_steps(n)

          puts "\n\n"
          puts "n = #{n}"
          garden_map.two_d_map.each do |line|
            line.each do |component|
              if reachable_plots_after_n_steps[component.location]
                print '0'
              else
                print component.char
              end
            end

            print "\n"
          end
        end

        puts "\n"
        puts "Starting from the garden plot marked S on your map, the number of garden plots can the Elf reach in exactly 64 steps: #{garden_plot_counter.find_reachable_plots_after_n_steps(64).keys.count}"
      end

      def garden_plot_counter
        @garden_plot_counter ||= Day21::GardenPlotCounter.new(garden_map)
      end

      def garden_map
        @garden_map ||= Day21::GardenMapBuilder.build(filepath)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
