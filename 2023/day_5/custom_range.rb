module Day5
  class CustomRange < Range
    def overlap?(other)
      cover?(other.first) || cover?(other.last)
    end
  end
end
