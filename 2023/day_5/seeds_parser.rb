module Day5
  class SeedsParser
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def seeds
      @seeds ||= primary_details.scan(/\d+/).map(&:to_i)
    end

    def primary_details
      @primary_details ||= str.split(':')[1]
    end
  end
end
