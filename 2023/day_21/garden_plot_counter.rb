module Day21
  class GardenPlotCounter
    attr_accessor :garden

    def initialize(garden)
      @garden = garden
    end

    def no_of_reachable_plots_after_n_steps(n = 1)
      queue = [starting_component]
      memoized = {}
      reachable_plot = {}

      no_of_steps = 1

      until queue.empty?
        level_size = queue.length

        until level_size.zero?
          curr_plot = queue.shift
          level_size -= 1

          puts "curr_plot: #{curr_plot.location}"
          # puts "queue: #{queue.map { |p| p.location } }"

          next_reachable_garden_plots = memoized[curr_plot.location]
          next_reachable_garden_plots ||= curr_plot.reachable_adjacent_plots
          memoized[curr_plot.location] ||= next_reachable_garden_plots

          puts "next_reachable_garden_plots: #{next_reachable_garden_plots.map { |c| c.location }}"
          puts "\n"

          if no_of_steps < n
            next_reachable_garden_plots.each { |garden_plot| queue << garden_plot }
          end

          if no_of_steps == n
            next_reachable_garden_plots.each { |garden_plot| reachable_plot[garden_plot.location] = true }
          end
        end

        no_of_steps += 1
      end

      reachable_plot.keys.count
      # no_of_reachable_plots
    end

    def starting_component
      @starting_component ||= garden.find_component_by_char('S')
    end
  end
end
