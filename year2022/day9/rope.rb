module Year2022
  module Day9
    class Rope
      attr_reader :head, :tail, :length

      def initialize(head)
        @head = head
        @tail = head
        @length = 1
      end

      def append_knot(knot)
        if @tail.prev_knot.nil?
          @tail = knot
          @head.next_knot = knot
          knot.prev_knot = @head
        else
          @tail.next_knot = knot
          knot.prev_knot = @tail
          @tail = knot
        end

        @length += 1
        @tail
      end

      def find_knot_by_location(location)
        curr_knot = head

        while curr_knot do
          return curr_knot if curr_knot.location == location

          curr_knot = curr_knot.next_knot
        end

        nil
      end

      def move(direction)
        curr_knot = head

        while curr_knot do
          if curr_knot.prev_knot.nil?
            curr_knot.location = next_location_by_direction(curr_knot.location, direction)
            break if curr_knot.touching_another?(curr_knot.next_knot)
          else
            break if curr_knot.touching_another?(curr_knot.prev_knot)

            if curr_knot.next_knot.nil?
              curr_knot.location = curr_knot.prev_knot.last_location.dup
            else
              curr_knot.location = curr_knot.prev_knot.last_location.dup
            end


            # candidate_next_location = next_location_by_direction(curr_knot.location, direction)

            # if candidate_next_location != curr_knot.prev_knot.last_location
            #   curr_knot.location = candidate_next_location
            #   curr_knot.location = curr_knot.prev_knot.last_location.dup unless curr_knot.touching_with_adjacent_knots?
            # else
            #
            # end
          end


          curr_knot = curr_knot.next_knot
        end
      end

      def next_location_by_direction(location, direction)
        case direction
        when 'U'
          [location[0], location[1] + 1]
        when 'D'
          [location[0], location[1] - 1]
        when 'R'
          [location[0] + 1, location[1]]
        when 'L'
          [location[0] - 1, location[1]]
        else
          raise ArgumentError, "Invalid direction: #{direction}"
        end
      end
    end
  end
end
