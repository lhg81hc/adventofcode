module Day11
  class PriorityQueue
    attr_reader :queue, :size

    QueueItem = Struct.new(:item, :priority)

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
      while i > 0 && queue[parent(i)].priority > queue[i].priority
        swap(parent(i), i)
        i = parent(i)
      end
    end

    def shift_down(i)
      max_index = i

      l = left_child(i)
      if l <= size && queue[l].priority < queue[max_index].priority
        max_index = l
      end

      r = right_child(i)
      if r <= size && queue[r].priority < queue[max_index].priority
        max_index = r
      end

      if i != max_index
        swap(i, max_index)
        shift_down(max_index)
      end
    end

    def insert(item, priority)
      @size += 1
      queue[size] = QueueItem.new(item, priority)

      shift_up(size)
    end

    def extract_min
      r = queue[0]
      queue[0] = queue[size]
      @size -= 1
      shift_down(0)
      queue.delete_at(size + 1)

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

    def empty?
      queue.empty?
    end

    private

    def swap(i, j)
      tmp = queue[i]
      queue[i] = queue[j]
      queue[j] = tmp

      nil
    end
  end
end
