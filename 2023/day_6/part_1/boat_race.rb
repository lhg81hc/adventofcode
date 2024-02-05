module Day6
  module Part1
    class BoatRace
      attr_reader :time, :record_distance

      def initialize(time, record_distance)
        @time = time
        @record_distance = record_distance
      end

      def racing_options
        (0..time).map do |hold_duration|
          {
            hold_duration: hold_duration,
            traveled_distance: distance_calculator(hold_duration)
          }
        end
      end

      def winning_options
        racing_options.select { |o| o[:traveled_distance] > record_distance }
      end


      def distance_calculator(hold_duration)
        speed = hold_duration * 1
        remaining_time = time - hold_duration

        speed * remaining_time
      end
    end
  end
end
