module Day20
  class Pulse
    LOW_PULSE = :low_pulse
    HIGH_PULSE = :high_pulse

    attr_reader :value, :from_module_name, :to_module_name

    def initialize(value, from_module_name, to_module_name)
      @value = value
      @from_module_name = from_module_name
      @to_module_name = to_module_name
    end

    def low?
      value == LOW_PULSE
    end

    def high?
      value == HIGH_PULSE
    end
  end
end
