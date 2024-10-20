module Year2022
  module Day15
    module OverlapMerging
      def merge_overlap(arr)
        merge_overlap!(Marshal.load(Marshal.dump(arr)))
      end

      def merge_overlap!(arr)
        arr.sort! { |a, b| a.first <=> b.first }

        idx = 0

        (1..(arr.length - 1)).each do |i|
          if arr[idx][1] >= arr[i][0]
            arr[idx][1] = [arr[idx][1], arr[i][1]].max
          else
            idx += 1
            arr[idx] = arr[i]
          end
        end

        arr.slice!(idx + 1, arr.length - 1 - idx) if idx < arr.length - 1
        arr
      end
    end
  end
end
