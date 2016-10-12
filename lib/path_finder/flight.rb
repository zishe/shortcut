module PathFinder
  class Flight
    attr_accessor :start, :end

    def initialize(input)
      @start, @end = input
    end

    def length
      @length ||= DistanceCalculator.calculate(
        *[@start.lat, @start.lon, @end.lat, @end.lon].map(&:to_rad)
      )
    end

    def to_s
      [@start.to_s, @end.to_s].join ' -> '
    end
  end
end
