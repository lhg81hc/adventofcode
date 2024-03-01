module Day15
  module HashingUtil
    def hash(str)
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
