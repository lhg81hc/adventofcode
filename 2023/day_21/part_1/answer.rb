require_relative '../garden_map_builder'
require_relative '../garden_plot_counter'

module Day21
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        puts garden_plot_counter.no_of_reachable_plots_after_n_steps(64)
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
