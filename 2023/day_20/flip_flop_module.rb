require_relative 'communication_module'

module Day20
  class FlipFlopModule < CommunicationModule
    OFF = :off
    ON = :on

    attr_reader :state

    def initialize(name, destination_modules_names)
      super
      @state = OFF
    end

    def off?
      state == OFF
    end

    def on?
      !off?
    end

    def flip_state
      @state = on? ? OFF : ON
    end

    def communicate(incoming_pulse)
      if incoming_pulse.low?
        outgoing_pulse_value = on? ? LOW_PULSE : HIGH_PULSE
        flip_state

        destination_modules_names.map do |dest_module_name|
          Day20::Pulse.new(outgoing_pulse_value, name, dest_module_name)
        end
      else
        []
      end
    end
  end
end
