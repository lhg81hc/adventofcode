module Day8
  module MyMath
    def greatest_common_divisor(a, b)
      if b.zero?
        [a, -a].max
      else
        greatest_common_divisor(b, a % b)
      end
    end

    def least_common_multiple(*args)
      temp = args.sort_by(&:abs)
      prev = nil

      temp.each.with_index do |curr, idx|
        if idx.zero?
          prev = curr
          next
        end

        prev = prev.abs * (curr.abs / greatest_common_divisor(prev,curr))
      end

      prev
    end
  end
end
