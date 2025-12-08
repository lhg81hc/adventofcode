module Year2025
  module Day1
    module Part1
      class Dial
        attr_reader :current_position, :password

        def initialize(current_position: 50)
          @current_position = current_position
          @password = 0
        end

        def rotate(rotation)
          @current_position = caculate_new_position(rotation)
          @password += 1 if @current_position.zero?

          @current_position
        end

        private

        def caculate_new_position(rotation)
          new_position =
            if rotation.to_the_left?
              @current_position - rotation.num_of_clicks
            else
              @current_position + rotation.num_of_clicks
            end

          if new_position.negative?
            new_position = (100 + (new_position % -100)) % 100
          else
            new_position = new_position % 100
          end

          new_position
        end
      end
    end
  end
end
