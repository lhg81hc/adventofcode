module Day23
  class HikingTrailMap
    attr_accessor :two_d_map

    def initialize(two_d_map = [])
      @two_d_map = two_d_map
    end

    def add_map_component(component)
      @two_d_map[component.line_idx] ||= []
      @two_d_map[component.line_idx][component.char_idx] = component
    end
  end
end
