module PathFinder
  class Flight
    attr_accessor :src, :dst

    def initialize(input)
      @src, @dst = input
    end

    def length
      @length ||= DistanceCalculator.calculate(
        *[@src.lat, @src.lon, @dst.lat, @dst.lon].map(&:to_rad)
      )
    end

    def to_s
      [@src.to_s, @dst.to_s].join ' -> '
    end
  end
end
