module Day18
  class Lagoon
    attr_reader :trenches

    def initialize(trenches)
      @trenches = trenches
    end

    def sketch
      @sketch ||=
        northernmost_lat.upto(southernmost_lat).inject([]) do |r, lat|
          westernmost_lng.upto(easternmost_lng).each do |lng|
            line_idx = lat - northernmost_lat

            r[line_idx] ||= []
            r[line_idx] << (trenches_coordinates["#{lat},#{lng}"] ? "#" : '.')
          end

          r
        end
    end

    def area
      northernmost_lat.upto(southernmost_lat).inject(0) do |s, lat|
        westernmost_lng.upto(easternmost_lng).each do |lng|
          if trenches_coordinates["#{lng},#{lat}"]
            puts "#{[lng, lat].join(',')} on the edge"
            s += 1
          else
            if point_in_polygon?([lng, lat])
              puts "#{[lng, lat].join(',')} is inside"
              s += 1
            else
              puts "#{[lng, lat].join(',')} is outside"
            end
          end
        end
        s
      end
    end

    def polygon_coordinates
      @polygon_coordinates ||=
        trenches.inject([]) do |r, trench|
          r << trench[-1]
          r
        end
    end

    def point_in_polygon?(point)
      x, y = point
      inside = false

      for i in (0..(polygon_coordinates.length - 1)) do
        j = i.zero? ? polygon_coordinates.length - 1 : i - 1

        xi = polygon_coordinates[i][0]
        yi = polygon_coordinates[i][1]
        xj = polygon_coordinates[j][0]
        yj = polygon_coordinates[j][1]

        intersect = ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi)
        inside = !inside if intersect
      end

      inside
    end

    def trenches_coordinates
      @trenches_coordinates ||=
        trenches.inject({}) do |h, trench|
          trench.each do |cube|
            h[cube.join(',')] = true
          end

          h
        end
    end

    def northernmost_lat
      @northernmost_lat ||=
        begin
          lat = nil

          trenches.each do |trench|
            trench.each do |cube|
              lat = cube[1] if lat.nil? || cube[1] < lat
            end
          end

          lat
        end
    end

    def southernmost_lat
      @southernmost_lat ||=
        begin
          lat = nil

          trenches.each do |trench|
            trench.each do |cube|
              lat = cube[1] if lat.nil? || cube[1] > lat
            end
          end

          lat
        end
    end

    def easternmost_lng
      @easternmost_lng ||=
        begin
          lng = nil

          trenches.each do |trench|
            trench.each do |cube|
              lng = cube[0] if lng.nil? || cube[0] > lng
            end
          end

          lng
        end
    end

    def westernmost_lng
      @westernmost_lng =
        begin
          lng = nil

          trenches.each do |trench|
            trench.each do |cube|
              lng = cube[0] if lng.nil? || cube[0] < lng
            end
          end

          lng
        end
    end
  end
end