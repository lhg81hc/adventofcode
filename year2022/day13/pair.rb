module Year2022
  module Day13
    class Pair
      attr_reader :first_package, :second_package

      def initialize(first_package, second_package)
        @first_package = first_package
        @second_package = second_package
      end

      def compare
        # The return value will whether 1 or -1 ('right order' or 'wrong order')
      end
    end
  end
end