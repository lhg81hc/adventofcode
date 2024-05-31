module Day1
  class MaxCaloriesFinder
    attr_reader :calories_group

    def initialize(calories_group)
      @calories_group = calories_group
    end

    def find_max
      max = calories_group.first.sum

      calories_group.each do |calories|
        sum_of_calories = calories.sum
        max = sum_of_calories if max < sum_of_calories
      end

      max
    end
  end
end
