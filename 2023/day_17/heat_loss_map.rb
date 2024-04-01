module Day17
  class HeatLossMap
    attr_reader :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def city_blocks
      File.foreach(inputpath).inject([]) do |r, str|
        str.each do |char|

        end

        r
      end
    end
  end
end
