module Day5
  class CustomRange < Range
    def overlap?(other)
      cover?(other.first) || other.cover?(first)
    end
  end
end
