module Day1
  class MaxCaloriesFinder
    attr_reader :calories_group

    def initialize(calories_group)
      @calories_group = calories_group
    end

    def find_max
      calories_group.reduce(calories_group.first.sum) do |max, calories|
        sum_of_calories = calories.sum
        max = sum_of_calories if max < sum_of_calories
        max
      end
    end

    def find_top_three
      heap = []

      calories_group.each do |calories|
        sum_of_calories = calories.sum

        if heap.length == 3
          next unless sum_of_calories > heap.first

          heap.shift
          heap.append(sum_of_calories)

        else
          heap.append(sum_of_calories)
        end

        index = heap.length - 1

        while index > 0 && heap[(index - 1) / 2] > heap[index]
          heap[(index - 1) / 2], heap[index] = heap[index], heap[(index - 1) / 2]
          index = (index - 1) / 2
        end
      end

      heap
    end
  end
end
