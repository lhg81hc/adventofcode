module Day25
  class DiagramComponent
    attr_reader :name, :other_connected_component_names

    def initialize(name, other_connected_component_names)
      @name = name
      @other_connected_component_names = other_connected_component_names
    end
  end
end
