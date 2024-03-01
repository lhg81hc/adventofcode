module Day14
  class RepeatingPatternFinder
    attr_reader :arr

    def initialize (arr)
      @arr = arr
    end


    def find
      for i in (0..last_index) do
        for j in ((i + 1)..last_index) do
          next unless arr[j] == arr[i]
          return [i, (j - i + 1)] if repeat?(i, j)
        end
      end

      [nil, nil]
    end

    def last_index
      @last_index ||= arr.length - 1
    end

    def repeat?(first_pattern_idx, second_pattern_index)
      gap = second_pattern_index - first_pattern_idx
      sub_arrs = []
      start = first_pattern_idx

      while start < last_index
        slice = arr.slice(start, gap)
        sub_arrs << slice if slice.length == gap
        start += (gap + 1)
      end

      return false if sub_arrs.length < 5

      sub_arrs.each.with_index do |sub_arr, idx|
        if sub_arr != sub_arrs[idx + 1]
          next if idx == sub_arrs.length - 1
          return false
        end
      end

      true
    end
  end
end
