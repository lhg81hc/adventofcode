module Year2022
  module Day13
    class Package
      attr_reader :items, :str

      def initialize(items, str)
        @items = items
        @str = str
      end
    end
  end
end
