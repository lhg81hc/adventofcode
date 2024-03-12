require_relative 'workflow_rule'

module Day19
  class Workflow
    attr_reader :val, :x, :m, :a, :s

    def initialize(val)
      @val = val
    end

    def examine_machine_part(part)
      rules.each do |rule|
        next_workflow = rule.examine_machine_part(part)
        return next_workflow unless next_workflow.nil?
      end
    end

    def name
      @name ||= val.match(/(\w+){/)[1]
    end

    def rules
      @rules ||=
        begin
          rules_str = val.match(/\{(.*)\}/)[1]
          rules_str.split(',').map do |rule_str|
            Day19::WorkflowRule.new(rule_str)
          end
        end
    end
  end
end
