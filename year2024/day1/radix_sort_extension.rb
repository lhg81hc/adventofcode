module Year2024
  module Day1
    module RadixSortExtension
      refine Array do
        def radix_sort!
          if self.length > 1
            non_negative_nums, negative_nums = self.partition { |e| e >= 0 }
            reversed_sign_negative_nums = negative_nums.map(&:abs)

            counting_sort_base_10(non_negative_nums)
            counting_sort_base_10(reversed_sign_negative_nums)

            return reversed_sign_negative_nums.reverse.map { |e| e * (-1) } + non_negative_nums
          end

          self
        end

        def counting_sort_base_10(arr)
          return arr unless arr.length > 1

          max = arr.max
          exp = 1

          while (max / exp) >= 1
            counting_arr = Array.new(10, 0)

            arr.each do |e|
              idx = e / exp
              counting_arr[idx % 10] += 1
            end

            (1..9).each do |idx|
              counting_arr[idx] += counting_arr[idx - 1]
            end

            output = []

            arr.reverse_each do |e|
              idx = e / exp
              output[counting_arr[idx % 10] - 1] = e
              counting_arr[idx % 10] -= 1
            end

            arr.each.with_index do |_e, idx|
              arr[idx] = output[idx]
            end

            exp *= 10
          end

          arr
        end
      end
    end
  end
end
