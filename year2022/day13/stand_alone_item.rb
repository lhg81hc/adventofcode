require_relative 'package_item'

module Year2022
  module Day13
    class StandAloneItem < Year2022::Day13::PackageItem
      attr_reader :value

      def initialize(value)
        @value = value
      end
    end
  end
end
