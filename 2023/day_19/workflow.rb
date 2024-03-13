require_relative 'workflow_rule'

module Day19
  class Workflow
    OPPOSITE_COMPARISONS = {
      '>' => '<=',
      '<' => '>=',
      '<=' => '>',
      '>=' => '<',
    }

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

    def rules_and_next_workflows_map
      rules.each_with_index.inject([]) do |r, (rule, rule_idx)|
        previous_rules =
          if rule_idx == 0
            []
          else
            rules[0..rule_idx - 1]
          end

        opposite_prev_rules = previous_rules.map { |pr| opposite_rule(pr) }
        curr_rules = opposite_prev_rules << rule
        condition = rules_to_key(curr_rules)
        condition = "{#{condition}}"

        r << { rules: curr_rules, next_workflow: rule.next_workflow, condition: condition }
        r
      end
    end

    def opposite_rule(rule)
      return nil if rule.non_comparison_rule?
      raise "Unknown comparison operator #{rule.comparison_operator}" unless OPPOSITE_COMPARISONS.keys.include?(rule.comparison_operator)

      opposite_comparison_operator = OPPOSITE_COMPARISONS[rule.comparison_operator]
      opposite_rule_str = [rule.rating, rule.rating_value].join(opposite_comparison_operator)
      Day19::WorkflowRule.new(opposite_rule_str)
    end

    def name
      @name ||= val.match(/(\w+){/)[1]
    end

    def rules_to_key(rules)
      comparisons = rules.map { |r| r.comparison }.select { |r| !r.nil? }
      "#{comparisons.join(',')}"
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
