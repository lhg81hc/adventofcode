require_relative 'communication_module'

module Day20
  class ConjunctionModule < CommunicationModule
    attr_reader :input_modules

    def initialize(name, destination_modules_names)
      super
      @input_modules = {}
    end

    def add_input_module(input_module_name)
      @input_modules[input_module_name] = LOW_PULSE
    end

    def remember_input_module_value(input_module_name, input_module_value)
      @input_modules[input_module_name] ||= input_module_value
    end

    def high_pulses_for_all_inputs?
      return false if input_modules.empty?

      input_modules.values.all? { |val| val == HIGH_PULSE }
    end

    def outgoing_pulse_value
      high_pulses_for_all_inputs? ? LOW_PULSE : HIGH_PULSE
    end

    def communicate(incoming_pulse)
      remember_input_module_value(incoming_pulse.from_module_name, incoming_pulse.value)

      destination_modules_names.map do |dest_module_name|
        Day20::Pulse.new(outgoing_pulse_value, name, dest_module_name)
      end
    end
  end
end
