module Day19
  class MachinePartRatings
    attr_reader :val

    def initialize(val)
      @val = val
    end

    def x
      @x ||= val.match(/x=(\d+),/)[1].to_i
    end

    def m
      @m ||= val.match(/m=(\d+),/)[1].to_i
    end

    def a
      @a ||= val.match(/a=(\d+),/)[1].to_i
    end

    def s
      @s ||= val.match(/s=(\d+)}/)[1].to_i
    end

    def sum
      x + m + a + s
    end
  end
end
