module Day15
  class HashingService
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def hash
      value = 0

      str.each_char do |char|
        value += char[0].ord
        value *= 17
        value = value % 256
      end

      value
    end
  end
end
