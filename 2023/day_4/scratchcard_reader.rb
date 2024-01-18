module Day4
  class ScratchcardReader
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def self.read(str)
      new(str).read
    end

    # Card   1: 72 42 34  7 30  3 25 63 99 15 | 63 30 64 15 72 55 73 32 75 41 37 77 49 51 95 16 25  3 92 18 87  2 71 28 10
    def read
      return self
    end

    def winning_numbers
      @winning_numbers ||=
        begin
          winning_numbers_part = primary_details.split(' | ').first
          winning_numbers_part.scan(/\d+/)
        end
    end

    def given_numbers
      @given_numbers ||=
        begin
          given_numbers_part = primary_details.split(' | ')[1]
          given_numbers_part.scan(/\d+/)
        end
    end

    def matched_numbers
      @matched_numbers ||= winning_numbers & given_numbers
    end

    def total_matched_numbers
      @total_matched_numbers ||= matched_numbers.length
    end

    def card_order_number
      @card_order_number ||= /\d+/.match(secondary_details).to_s.to_i
    end

    def card_point
      return total_matched_numbers if total_matched_numbers.zero? || total_matched_numbers == 1

      2 ** (total_matched_numbers - 1)
    end

    def secondary_details
      @secondary_details ||= str.split(':').first
    end

    def primary_details
      @primary_details ||= str.split(':')[1]
    end
  end
end