module Day15
  class Lens
    attr_reader :label, :focal_length

    def initialize(label, focal_length)
      @label = label
      @focal_length = focal_length
    end
  end
end
