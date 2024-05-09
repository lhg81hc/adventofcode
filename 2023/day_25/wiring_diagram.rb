module Day25
  class WiringDiagram
    attr_reader :list

    def initialize(list = [])
      @list = list
    end

    def add_component(component)
      @list << component
    end
  end
end
