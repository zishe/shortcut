module PathFinder
  class DistanceCalculator
    RADIUS = 6378.14

    class << self
      include Math

      # The haversine formula
      # https://en.wikipedia.org/wiki/Haversine_formula
      def calculate(lat1, lon1, lat2, lon2)
        d_lon = lon1 - lon2
        d_lat = lat1 - lat2

        a = sin(d_lat/2)**2 + cos(lat1) * cos(lat2) * sin(d_lon/2)**2
        2 * RADIUS * atan2(sqrt(a), sqrt(1-a))
      end
    end
  end
end
