module Day25
  class WiringDiagram
    attr_reader :connections

    def initialize(connections = [])
      @connections = connections
    end

    def add_connection(connection)
      @connections << connection
    end
  end
end
