module Day13
  class Pattern
    attr_reader :input_lines

    def initialize(input_lines)
      @input_lines = input_lines
    end

    def rows
      @rows ||= rows_and_cols[0]
    end

    def cols
      @cols ||= rows_and_cols[1]
    end

    private

    def rows_and_cols
      @rows_and_cols ||=
        begin
          rows_tmp = []
          cols_tmp = []

          input_lines.each do |line|
            row = []

            line.each_char.with_index do |char, char_idx|
              row << char
              cols_tmp[char_idx] ||= []
              cols_tmp[char_idx] << char
            end

            rows_tmp << row
          end

          [rows_tmp, cols_tmp]
        end
    end
  end
end
