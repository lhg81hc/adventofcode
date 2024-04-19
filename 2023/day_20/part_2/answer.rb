require_relative '../button_module'
require_relative '../module_configuration'
require_relative '../module_configuration_line_parser'

module Day20
  module Part2
    class Answer
      def self.run
        new.run
      end

      # Idea:
      # In order for '&kc' to send L to '&rx'
      # Firstly, '&ph' needs to H to '&kc' which means '&nh' needs to send L to '&ph'
      # Secondly, '&vn' needs to H to '&kc' which means '&mf' needs to send L to '&vn'
      # Thirdly, '&kt' needs to H to '&kc' which means '&fd' needs to send L to '&kt'
      # Lastly, '&hn' needs to H to '&kc' which means '&kb' needs to send L to '&nh'

      # Therefore the original problem now becomes find the number of buttons presses so that:
      #
      # '&nh' to send L to '&ph' AND
      #   '&mf' to send L to '&vn' AND
      #   '&fd' to send L to '&kt' AND
      #   '&kb' to send L to '&nh'

      # Notice that '&nh', '&mf', '&fd', '&kb' are conjunctions modules which inputs are lists of SEPARATED components
      # therefore "the number of button presses is the LCM of number of presses for each module to send their first LOW pulse out"

      def run
        module_configuration = build_module_configuration
        num_of_button_presses_for_nh_to_send_low_to_ph = module_configuration.push_button_until_first_low_pulse_between_modules('nh', 'ph')
        puts "For '&nh' to send its first LOW pulse to '&ph': #{num_of_button_presses_for_nh_to_send_low_to_ph} button presses"

        num_of_button_presses_for_mf_to_send_low_to_vn = module_configuration.push_button_until_first_low_pulse_between_modules('mf', 'vn')
        puts "For '&mf' to send its first LOW pulse to '&vn': #{num_of_button_presses_for_mf_to_send_low_to_vn} button presses"

        num_of_button_presses_for_fd_to_send_low_to_kt = module_configuration.push_button_until_first_low_pulse_between_modules('fd', 'kt')
        puts "For '&fd' to send its first LOW pulse to '&kt': #{num_of_button_presses_for_fd_to_send_low_to_kt} button presses"

        num_of_button_presses_for_kb_to_send_low_to_hn = module_configuration.push_button_until_first_low_pulse_between_modules('kb', 'hn')
        puts "For '&kb' to send its first LOW pulse to '&hn': #{num_of_button_presses_for_kb_to_send_low_to_hn} button presses"

        puts "\n"

        lcm =  least_common_multiple(
          num_of_button_presses_for_nh_to_send_low_to_ph,
          num_of_button_presses_for_mf_to_send_low_to_vn,
          num_of_button_presses_for_fd_to_send_low_to_kt,
          num_of_button_presses_for_kb_to_send_low_to_hn
        )

        puts "Number of button presses for &rx to receive its first LOW pulse is: #{lcm}"
      end

      def button_module
        Day20::ButtonModule.new('button', ['broadcaster'])
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end

      def build_module_configuration
        configuration = ModuleConfiguration.new({ button_module.name => button_module })

        File.foreach(input_path) do |line|
          communication_module = Day20::ModuleConfigurationLineParser.new(line.strip).parse
          configuration.add_communication_module(communication_module)
        end

        configuration
      end

      def greatest_common_divisor(a, b)
        if b.zero?
          [a, -a].max
        else
          greatest_common_divisor(b, a % b)
        end
      end

      def least_common_multiple(*args)
        temp = args.sort_by(&:abs)
        prev = nil

        temp.each.with_index do |curr, idx|
          if idx.zero?
            prev = curr
            next
          end

          prev = prev.abs * (curr.abs / greatest_common_divisor(prev,curr))
        end

        prev
      end
    end
  end
end