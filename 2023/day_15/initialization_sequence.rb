module Day15
  class InitializationSequence
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def steps
      @steps ||=
        begin
          str.split(',')
        end
    end
  end
end
