module Day15
  class Box
    attr_reader :lenses, :box_no

    def initialize(box_no, lenses = [])
      @lenses = lenses
      @box_no = box_no
    end

    def add_lens(lens)
      found_idx = lenses.index { |l| l.label == lens.label }

      if found_idx
        @lenses[found_idx] = lens
      else
        @lenses << lens
      end

      lenses
    end

    def remove_lens(lens)
      found_idx = lenses.index { |l| l.label == lens.label }
      @lenses.slice!(found_idx) if found_idx
    end
  end
end
