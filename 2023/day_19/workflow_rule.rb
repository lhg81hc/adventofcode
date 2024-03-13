module Day19
  class WorkflowRule
    attr_reader :val

    def initialize(val)
      @val = val
    end

    def examine_machine_part(part)
      return val if non_comparison_rule?

      applicable_rating = part.send(rating)

      if applicable_rating.send(comparison_operator, rating_value)
        next_workflow
      else
        nil
      end
    end

    def rating
      @rating ||=
        begin
          return nil if non_comparison_rule?

          matched = val.scan(/(\w)>|(\w)</)[0]

          if matched.nil?
            nil
          else
            matched[0] || matched[1]
          end
        end
    end

    def comparison_operator
      @comparison_operator ||=
        begin
          return nil if non_comparison_rule?

          matched = val.scan(/(<=)|(>=)|(>)|(<)/)[0]
          matched[0] || matched[1] || matched[2] || matched[3]
        end
    end

    def rating_value
      @rating_value ||=
        begin
          return nil if non_comparison_rule?

          matched = val.scan(/(\d+):/)[0]

          if matched.nil?
            nil
          else
            matched[0].to_i
          end
        end
    end

    def next_workflow
      @next_workflow ||=
        begin
          return val if non_comparison_rule?

          val.match(/:(\w+)/)[1]
        end
    end

    def non_comparison_rule?
      !val.include?(':')
    end
  end
end
