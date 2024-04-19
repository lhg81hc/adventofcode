require_relative 'pulse'

module Day20
  class ModuleConfiguration
    attr_reader :module_dict

    def initialize(module_dict = {})
      @module_dict = module_dict
    end

    def add_communication_module(communication_module)
      @module_dict[communication_module.name] ||= communication_module

      if communication_module.is_a?(ConjunctionModule)
        init_new_input_modules_list(communication_module)
      else
        update_existing_input_modules(communication_module)
      end
    end

    def init_new_input_modules_list(conjunction_module)
      module_dict.values.each do |v|
        next if v.name == conjunction_module.name

        v.destination_modules_names.each do |dest_module_name|
          if dest_module_name == conjunction_module.name
            conjunction_module.add_input_module(v.name)
          end
        end
      end
    end

    def update_existing_input_modules(non_conjunction_module)
      non_conjunction_module.destination_modules_names.each do |dest_module_name|
        dest_module = module_dict[dest_module_name]
        next unless dest_module

        dest_module.add_input_module(non_conjunction_module.name) if dest_module.is_a?(ConjunctionModule)
      end
    end

    def push_button_module!
      pulse_queue = [starting_pulse]

      total_low_pulses = 0
      total_high_pulses = 0

      until pulse_queue.empty?
        curr_pulse = pulse_queue.shift
        curr_module_name = curr_pulse.to_module_name
        curr_module = module_dict[curr_module_name]

        if curr_pulse.low?
          total_low_pulses += 1
        else
          total_high_pulses += 1
        end

        puts "#{curr_pulse.from_module_name} -#{curr_pulse.value}-> #{curr_pulse.to_module_name.to_s}"
        next if curr_module.nil?

        curr_module.communicate(curr_pulse).each { |outgoing_pulse| pulse_queue << outgoing_pulse }
      end

      [total_low_pulses, total_high_pulses]
    end

    def push_button_until_first_low_pulse_between_modules(from_module_name, to_module_name)
      count = 1
      low_pulse_sent = false
      cloned_module_dict = clone_module_dict

      until low_pulse_sent
        pulse_queue = [starting_pulse]

        until pulse_queue.empty?
          curr_pulse = pulse_queue.shift
          curr_module_name = curr_pulse.to_module_name
          curr_module = cloned_module_dict[curr_module_name]

          low_pulse_sent =
            curr_pulse.low? &&
            curr_pulse.from_module_name == from_module_name &&
            curr_pulse.to_module_name == to_module_name

          break if low_pulse_sent
          next if curr_module.nil?

          curr_module.communicate(curr_pulse).each { |outgoing_pulse| pulse_queue << outgoing_pulse }
        end

        count += 1
      end

      count
    end

    def clone_module_dict
      Marshal.load(Marshal.dump(module_dict))
    end

    def starting_pulse
      Day20::Pulse.new(:low_pulse, 'button', 'broadcaster')
    end
  end
end
