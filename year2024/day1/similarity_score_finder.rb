module Year2024
  module Day1
    class SimilarityScoreFinder
      attr_reader :first_list, :second_list

      def initialize(first_list, second_list)
        @first_list = first_list
        @second_list = second_list
      end

      def score
        map =
          second_list.inject({}) do |r, e|
            r[e] ||= 0
            r[e] += 1
            r
          end

        first_list.inject(0) do |r, e|
          r += e * map[e] unless map[e].nil?
          r
        end
      end
    end
  end
end