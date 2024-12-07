module Year2024
  module Day1
    module CountingSortExtension
      refine Array do
        def counting_sort!
          if self.length > 1
            max = self.max

            counting_arr = Array.new(max + 1, 0)

            self.each do |e|
              counting_arr[e] += 1
            end

            (1..max).each do |idx|
              counting_arr[idx] += counting_arr[idx - 1]
            end

            i = self.length - 1
            output = Array.new(i, 0)

            while i >= 0
              output[counting_arr[self[i]] - 1] = self[i]
              counting_arr[self[i]] -= 1

              i -= 1
            end

            return output
          end

          self
        end
        # def radix_sort!
        #   if self.length > 1
        #     non_negative_nums, negative_nums = self.partition { |e| e >= 0 }
        #     reversed_sign_negative_nums = negative_nums.map(&:abs)
        #
        #     p "non_negative_nums: #{non_negative_nums}"
        #     p "negative_nums: #{negative_nums}"
        #     counting_sort_base_10(non_negative_nums)
        #     counting_sort_base_10(reversed_sign_negative_nums)
        #
        #     return reversed_sign_negative_nums.reverse.map { |e| e * (-1) } + non_negative_nums
        #   end
        #
        #   self
        # end
        #
        # def counting_sort(arr)
        #   return arr unless arr.length > 1
        #
        #   max = arr.max
        #
        #   counting_arr = Array.new(max + 1, 0)
        #
        #   arr.each do |e|
        #     counting_arr[e] += 1
        #   end
        #
        #   (1..max).each do |idx|
        #     counting_arr[idx] += counting_arr[idx - 1]
        #   end
        #
        #   output_arr = Array.new(arr.length, 0)
        #
        #   i = arr.length
        #   while i >= 0
        #     t = arr[i]
        #
        #     arr[counting_arr[t] - 1] = t
        #     counting_arr[t] -= 1
        #
        #     i -= 1
        #   end
        #
        #   output_arr
        # #   while (max / exp) > 0
        # #     counting_arr = Array.new(max + 1, 0)
        # #
        # #     arr.each do |e|
        # #       idx = e / exp
        # #       counting_arr[idx % 10] += 1
        # #     end
        # #
        # #     counting_arr.each.with_index do |e, idx|
        # #       counting_arr[idx] = counting_arr[idx - 1] + e
        # #     end
        # #
        # #     output = []
        # #
        # #     arr.reverse_each do |e|
        # #       idx = e / exp
        # #       output[counting_arr[idx % 10] - 1] = e
        # #       counting_arr[idx % 10] -= 1
        # #     end
        # #
        # #     arr.each.with_index do |_e, idx|
        # #       arr[idx] = output[idx]
        # #     end
        # #
        # #     exp *= 10
        # #   end
        # #
        # #   arr
        # end
      end
    end
  end
end
