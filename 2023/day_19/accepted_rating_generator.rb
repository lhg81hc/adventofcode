module Day19
  class AcceptedRatingGenerator
    attr_reader :workflows

    def initialize(workflows)
      @workflows = workflows
    end

    def accepted_rating_list
      @visited = {}
      @stack = []
      @list = []
      @count = 0

      generate_accepted_rating_combination('in', '{s<1351}')

      @list
    end

    # in{s<1351}->qqz{s>2770}->A
    #
    #
    #
    # Idea:
    # 1. Add the current workflow name to the 'stack'
    # 2. Call #rules_and_next_workflows_map on current workflow to get all the possible combination of rules
    # 3. If the current workflow does not lead to 'A' or 'R' immediately then add the key into the 'visited'
    #
    # 2. Call #reflections to get the next locations and directions
    # 3. Filter the location and direction that have been visited (#reflection() can lead to loop)
    # 4. If the #reflection returns an array, then add the current component to the stack and recursively check the return values first
    # 5. After finish checking return values recursively, pop the latest component from the stack and recheck
    # 6. The base case is when the @stack is empty
    def generate_accepted_rating_combination(workflow_name, condition)
      @visited["#{workflow_name}#{condition}"] = true

      curr_workflow = workflows[workflow_name]
      next_rules_and_workflows = curr_workflow.rules_and_next_workflows_map
      t = next_rules_and_workflows.find { |r| r[:condition] == condition }
      raise "Something is not right" unless t

      if t[:next_workflow] == 'A' || t[:next_workflow] == 'R'
        if t[:next_workflow] == 'A'
          history = @stack.dup
          history << { workflow_name: workflow_name, condition: condition }
          # puts history.map(&:to_s).join(" | ")

          @list << history
        end

        unvisited_rules_and_workflows = next_rules_and_workflows.select { |h| @visited["#{workflow_name}#{h[:condition]}"].nil? }

        if unvisited_rules_and_workflows.empty?
          stacked = @stack.pop

          while stacked
            stacked_workflow_name = stacked[:workflow_name]
            stacked_workflow = workflows[stacked_workflow_name]
            unvisited_stacked_workflows = stacked_workflow.rules_and_next_workflows_map.select { |h| @visited["#{stacked_workflow_name}#{h[:condition]}"].nil? }

            if unvisited_stacked_workflows.empty?
              stacked = @stack.pop
            else
              next_workflow = unvisited_stacked_workflows.first
              next_workflow_name = stacked_workflow.name
              next_key = next_workflow[:condition]
              break
            end
          end

          return nil if stacked.nil?
        else
          next_workflow = unvisited_rules_and_workflows.first
          next_workflow_name = workflow_name
          next_key = next_workflow[:condition]
        end

      else
        @stack << { workflow_name: workflow_name, condition: condition }
        next_workflow_name = t[:next_workflow]
        next_workflow = workflows[next_workflow_name]
        next_key = next_workflow.rules_and_next_workflows_map.first[:condition]
      end

      generate_accepted_rating_combination(next_workflow_name, next_key)
    end
  end
end
