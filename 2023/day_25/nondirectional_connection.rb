module Day25
  class NondirectionalConnection
    attr_reader :first_component, :second_component

    def initialize(first_component, second_component = nil)
      @first_component = first_component
      @second_component = second_component
    end

    def add_second_component(c)
      @second_component = c
    end

    def components
      [first_component, second_component]
    end

    def open?
      components.any?(&:nil?)
    end
  end
end
