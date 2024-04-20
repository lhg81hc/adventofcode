module Day21
  class GardenPlotCounter
    attr_accessor :garden

    def initialize(garden)
      @garden = garden
    end

    def reachable_plots_after_n_steps(n = 1)
      return @memo[n] if @memo[n]

      reachable_plots = {}

      if n == 1
        curr_plot = starting_component
        curr_plot.reachable_adjacent_plots.each { |garden_plot| reachable_plots[garden_plot.location] = true }
      end

      if n == 2
        queue = [starting_component]
        no_of_steps = 1

        until queue.empty?
          level_size = queue.length

          until level_size.zero?
            curr_plot = queue.shift
            level_size -= 1

            next_reachable_garden_plots = curr_plot.reachable_adjacent_plots

            if no_of_steps < n
              next_reachable_garden_plots.each { |garden_plot| queue << garden_plot }
            end

            if no_of_steps == n
              next_reachable_garden_plots.each { |garden_plot| reachable_plots[garden_plot.location] = true }
            end
          end

          no_of_steps += 1
        end
      end

      if n > 2
        reachable_plots_after_previous_step = reachable_plots_after_n_steps(n - 1)

        reachable_plots_after_previous_step.keys.each do |plot_location|
          curr_plot = garden.find_component_by_location(plot_location.split(',').map(&:to_i))
          next_reachable_garden_plots = curr_plot.reachable_adjacent_plots
          next_reachable_garden_plots.each { |garden_plot| reachable_plots[garden_plot.location] = true }
        end
      end

      @memo[n] = reachable_plots
      reachable_plots
    end

    def find_reachable_plots_after_n_steps(n)
      @memo = {}
      reachable_plots_after_n_steps(n)
    end

    def starting_component
      @starting_component ||= garden.find_component_by_char('S')
    end
  end
end
