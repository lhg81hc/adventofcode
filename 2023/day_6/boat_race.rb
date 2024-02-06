module Day6
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

    def hold_durations
      @hold_durations ||= (0..time).to_a
    end

    # Eg: Target is 14
    # [0..32] --> mid = 16 and found = 16
    # [0..15] --> mid = 7 and found = 16
    # [8..15] --> mid = 11 and found = 16
    # [12..15] --> mid = 13 and found = 16
    # [13..15] --> mid = 14 and found = 14
    # [13..13] --> mid = 13 and found = 14
    # [14..13] --> break
    def min_hold_duration_to_win
      low = 0
      high = time
      found = nil

      while low <= high
        mid = (low + high) / 2

        hold_duration = hold_durations[mid]
        distance = distance_calculator(hold_duration)

        if distance > record_distance
          if found.nil? || found >= hold_duration
            found = hold_duration
          end

          high = mid - 1
        else
          low = mid + 1
        end
      end

      found
    end

    # Eg: target is 31
    # [0..50] --> mid = 25 and found = 25
    # [26..50] --> mid = 38 and found = 25
    # [26..37] --> mid = 31 and found = 31
    # [32..37] --> mid = 34 and found = 31
    # [32..33] --> mid = 32 and found = 31
    # [32..31] --> break
    def max_hold_duration_to_win
      low = 0
      high = time
      found = nil

      while low <= high
        mid = (low + high) / 2

        hold_duration = hold_durations[mid]
        distance = distance_calculator(hold_duration)

        if distance > record_distance
          if found.nil? || found <= hold_duration
            found = hold_duration
          end

          low = mid + 1
        else
          high = mid - 1
        end
      end

      found
    end

    def distance_calculator(hold_duration)
      speed = hold_duration * 1
      remaining_time = time - hold_duration

      speed * remaining_time
    end
  end
end
