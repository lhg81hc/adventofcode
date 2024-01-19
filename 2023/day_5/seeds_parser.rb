require_relative 'custom_range'

module Day5
  class SeedsParser
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def seeds
      @seeds ||= primary_details.scan(/\d+/).map(&:to_i)
    end

    def ranges_of_seed_numbers
      @ranges_of_seed_numbers ||=
        (0..(seeds.length - 1)).step(2).map do |idx|
          CustomRange.new(seeds[idx], seeds[idx] + seeds[idx + 1] - 1)
        end
    end

    def primary_details
      @primary_details ||= str.split(':')[1]
    end
  end
end
