require_relative 'communication_module'

module Day20
  class BroadcastModule < CommunicationModule
    def communicate(incoming_pulse)
      destination_modules_names.map do |dest_module_name|
        Day20::Pulse.new(incoming_pulse.value, name, dest_module_name)
      end
    end
  end
end
