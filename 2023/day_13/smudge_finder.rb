module Day13
  class SmudgeFinder
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def find_reflection
      lines.each.with_index do |line, line_idx|
        return line_idx + 1 if reflection_line_with_smudge?(line, line_idx)
      end

      nil
    end

    def total_lines
      @total_lines ||= lines.length
    end

    private

    def reflection_line_with_smudge?(line, idx)
      next_line = lines[idx + 1]
      return false if next_line.nil?

      num_of_differences = num_of_differences_between_2_arrays(line, next_line)

      return false if num_of_differences > 1
      return true if idx.zero? && num_of_differences == 1

      smudge_found = num_of_differences.positive?

      if idx >= (total_lines / 2)
        (idx - 1).downto(0) do |i|
          reflection_idx = idx + 1 + (idx - i) # (idx - i) is the gap
          reflection_line = lines[reflection_idx]

          break if reflection_line.nil?

          num_of_differences = num_of_differences_between_2_arrays(lines[i], reflection_line)
          return false if num_of_differences > 1
          if num_of_differences.zero?
            next
          else
            if smudge_found
              return false
            else
              smudge_found = true
              next
            end
          end
        end
      else
        (idx + 2).upto(total_lines - 1) do |i|
          reflection_idx = idx - (i - (idx + 1)) # (i - (idx + 1)) is the gap
          reflection_line = lines[idx - (i - (idx + 1))]

          break if reflection_idx.negative? || reflection_line.nil?

          num_of_differences = num_of_differences_between_2_arrays(lines[i], reflection_line)
          return false if num_of_differences > 1
          if num_of_differences.zero?
            next
          else
            if smudge_found
              return false
            else
              smudge_found = true
              next
            end
          end
        end
      end

      smudge_found
    end

    def num_of_differences_between_2_arrays(arr1, arr2)
      arr1.each.with_index.inject(0) do |count, (char, char_idx)|
        count += 1 if char != arr2[char_idx]
        count
      end
    end
  end
end
