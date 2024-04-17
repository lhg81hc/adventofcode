require_relative 'communication_module'

module Day20
  class ButtonModule < CommunicationModule
    def communicate(_incoming_pulse)
      destination_modules_names.map do |dest_module_name|
        Day20::Pulse.new(LOW_PULSE, name, dest_module_name)
      end
    end
  end
end
