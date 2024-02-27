module Day13
  class ReflectionFinder
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def find
      lines.each.with_index.inject([]) do |found, (line, line_idx)|
        found << line_idx + 1 if reflection_line?(line, line_idx)
        found
      end
    end

    private

    def reflection_line?(line, idx)
      next_line = lines[idx + 1]

      return false if next_line.nil? || next_line != line
      return true if idx.zero? && next_line == line

      if idx >= (total_lines / 2)
        (idx - 1).downto(0) do |i|
          reflection_idx = idx + 1 + (idx - i) # (idx - i) is the gap
          reflection_line = lines[reflection_idx]

          break if reflection_line.nil?
          return false if lines[i] != reflection_line
        end
      else
        (idx + 2).upto(total_lines - 1) do |i|
          reflection_idx = idx - (i - (idx + 1)) # (i - (idx + 1)) is the gap
          reflection_line = lines[idx - (i - (idx + 1))]

          break if reflection_idx.negative? || reflection_line.nil?
          return false if lines[i] != reflection_line
        end
      end

      true
    end

    def total_lines
      @total_lines ||= lines.length
    end
  end
end
