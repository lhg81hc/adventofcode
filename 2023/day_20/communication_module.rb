module Day20
  class CommunicationModule
    LOW_PULSE = :low_pulse
    HIGH_PULSE = :high_pulse

    attr_reader :name, :destination_modules_names

    def initialize(name, destination_modules_names)
      @name = name
      @destination_modules_names = destination_modules_names
    end

    def communicate(_incoming_pulse)
      raise 'Undefined'
    end
  end
end
