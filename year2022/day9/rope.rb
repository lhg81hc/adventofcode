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
        if head_only?
          append_knot_to_head(knot)
        else
          append_knot_to_tail(knot)
        end

        @length += 1
        @tail
      end

      def move(direction)
        curr_knot = head

        while curr_knot do
          prev_knot = curr_knot.prev_knot
          next_knot = curr_knot.next_knot

          next_location =
            if prev_knot.nil?
              curr_knot.next_location_by_direction(direction)
            else
              curr_knot.next_location_to_follow_head_knot(prev_knot)
            end

          break if next_location == curr_knot.location

          curr_knot.location = next_location
          curr_knot = next_knot
        end
      end

      private

      def head_only?
        tail.object_id == head.object_id
      end

      def append_knot_to_head(knot)
        @tail = knot
        @head.next_knot = @tail
        @tail.prev_knot = @head
      end

      def append_knot_to_tail(knot)
        @tail.next_knot = knot
        knot.prev_knot = @tail
        @tail = knot
      end
    end
  end
end
