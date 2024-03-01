require_relative 'box'
require_relative 'lens'
require_relative 'initialization_step'

module Day15
  class InitializationSequenceExecutor
    attr_reader :sequence, :boxes

    def initialize(sequence)
      @sequence = sequence
      @boxes = (0..255).map { |n| Box.new(n) }
    end

    def execute
      sequence.steps.each { |initialization_str| execute_step(initialization_str) }
      boxes
    end

    def execute_step(initialization_str)
      step = Day15::InitializationStep.new(initialization_str)
      lens = Day15::Lens.new(step.label_of_the_lens, step.focal_length)

      box = @boxes[step.box_no]
      raise "Invalid box number after hashing from '#{step.label_of_the_lens}'" if box.nil?

      case step.operation
      when '-'
        box.remove_lens(lens)
      when '='
        box.add_lens(lens)
      else
        raise "Unknown operation #{step.operation}"
      end

      puts "After '#{initialization_str}'"
      print_boxes
    end

    def print_boxes
      boxes.each do |b|
        next if b.lenses.empty?
        puts "Box #{b.box_no}: #{b.lenses.map { |l| "[#{l.label} #{l.focal_length}]" }.join(' ')}"
      end

      puts "\n"
    end
  end
end
