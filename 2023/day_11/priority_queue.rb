module Day11
  class PriorityQueue
    attr_reader :queue, :size

    def initialize(queue = [])
      @queue = queue
      @size = queue.length - 1
    end

    def parent(i)
      (i - 1) / 2
    end

    def left_child(i)
      (2 * i) + 1
    end

    def right_child(i)
      (2 * i) + 2
    end

    def shift_up(i)
      while i > 0 && queue[parent(i)] > queue[i]
        swap(parent(i), i)
        i = parent(i)
      end
    end

    def shift_down(i)
      max_index = i

      l = left_child(i)
      if l <= size && queue[l] < queue[max_index]
        max_index = l
      end

      r = right_child(i)
      if r <= size && queue[r] < queue[max_index]
        max_index = r
      end

      if i != max_index
        swap(i, max_index)
        shift_down(max_index)
      end
    end

    def insert(p)
      @size += 1
      queue[size] = p

      shift_up(size)
    end

    def extract_min
      r = queue[0]
      queue[0] = queue[size]
      @size -= 1
      shift_down(0)

      r
    end

    def get_min
      queue[0]
    end

    def remove(i)
      queue[i] = get_min + 1
      shift_up(i)
      extract_min
    end

    private

    def swap(i, j)
      puts "Calling swap(#{i}, #{j})"
      tmp = queue[i]
      queue[i] = queue[j]
      queue[j] = tmp

      nil
    end
  end
end
