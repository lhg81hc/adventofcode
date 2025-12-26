module Year2025
  module Day1
    class Dial
      attr_reader :current_position, :password, :password_0x434C49434B

      def initialize(current_position: 50)
        @current_position = current_position
        @password = 0
        @password_0x434C49434B = 0
      end

      def rotate(rotation)
        new_position = calculate_new_position(rotation)

        update_password_0x434C49434B(rotation)
        update_password if new_position.zero?

        @current_position = new_position
        @current_position
      end

      private

      def calculate_new_position(rotation)
        (@current_position + rotation.to_i) % 100
      end

      def update_password
        @password += 1
      end

      def update_password_0x434C49434B(rotation)
        new_position = @current_position + rotation.to_i

        if new_position.zero?
          @password_0x434C49434B += 1
          return @password_0x434C49434B
        end

        if rotation.to_the_left?
          if new_position.negative?
            if new_position > -100
              @password_0x434C49434B += 1 if @current_position > 0
            else
              @password_0x434C49434B += (new_position / -100) if current_position.zero?
              @password_0x434C49434B += ((new_position / -100) + 1) if current_position.positive?
            end
          end
        end

        if rotation.to_the_right?
          @password_0x434C49434B += (new_position / 100) if new_position >= 100
        end

        @password_0x434C49434B
      end
    end
  end
end
