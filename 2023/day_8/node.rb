module Day8
  class Node
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def scanned_str
      @scanned_str ||= str.scan(/[A-Z]+/)
    end

    def value
      scanned_str.first
    end

    def left
      scanned_str[1]
    end

    def right
      scanned_str[-1]
    end

    def turn(val)
      raise "Invalid move" unless ['R', 'L'].include?(val)

      val == 'R' ? right : left
    end
  end
end
