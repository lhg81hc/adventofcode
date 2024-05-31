module Day1
  class InputParser
    attr_reader :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def self.parse(filepath)
      new(filepath).parse
    end

    def parse
      list = []
      current_items = []

      File.foreach(filepath) do |line|
        if line.strip.empty?
          list << current_items.dup
          current_items = []
        else
          current_items << line.strip.to_i
        end
      end

      list << current_items.dup
      list
    end
  end
end
