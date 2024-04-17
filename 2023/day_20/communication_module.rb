module Day20
  class CommunicationModule
    LOW_PULSE = :low_pulse
    HIGH_PULSE = :high_pulse

    attr_reader :prefix, :state, :name, :destination_modules_names, :input_modules

    def initialize(name, destination_modules_names, prefix = nil, type = nil)
      @prefix = prefix
      @name = name
      @type = type
      @destination_modules_names = destination_modules_names

      @state = FLIP_FLOP_OFF if flip_flop?
      @input_modules = {} if conjunction?
    end

    def type
      @type || MODULE_TYPE_MAP.fetch(prefix)
    end

    def flip_flop?
      type == FLIP_FLOP
    end

    def conjunction?
      type == CONJUNCTION
    end

    def broadcaster?
      type == BROADCASTER
    end

    def button?
      type == BUTTON
    end

    def off?
      state == FLIP_FLOP_OFF
    end

    def on?
      !off?
    end

    def add_input_module(input_module_name)
      return if input_modules.fetch(input_module_name)
      @input_modules[input_module_name] = LOW_PULSE
    end

    def communicate(received_pulse)
      send("#{type}_communication", received_pulse)
    end

    def flip_flop_communication(received_pulse)
      outgoing_pulse = nil
      outgoing_module_names = []

      if received_pulse == LOW_PULSE
        outgoing_module_names = destination_modules_names

        if on?
          @state = FLIP_FLOP_OFF
          outgoing_pulse = LOW_PULSE
        else
          @state = FLIP_FLOP_ON
          outgoing_pulse = HIGH_PULSE
        end
      end

      [outgoing_pulse, outgoing_module_names]
    end

    def broadcaster_communication(received_pulse)
      [received_pulse, outgoing_module_names]
    end

    def button_communication(_received_pulse)
      [LOW_PULSE, outgoing_module_names]
    end

    def conjunction_communication(received_pulse)

    end
  end
end