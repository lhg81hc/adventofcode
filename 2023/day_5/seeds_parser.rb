module Day5
  class SeedsParser
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def seeds
      @seeds ||= str.split(':')[1].scan(/\d+/).map(&:to_i)
    end
  end
end
