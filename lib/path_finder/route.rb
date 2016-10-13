module PathFinder
  class Route
    attr_accessor :src, :dst, :flights, :current, :past_cities

    def initialize(input)
      @src, @dst = input
      @current = @src
      @past_cities = []
      @flights = []
      @complete = false
    end

    def add_flight(flight)
      @flights << flight
      @current = flight.dst
      @past_cities << @current
      @complete = true if @current.name == @dst.name
    end

    def completed?
      @complete
    end

    def length
      @length ||= @flights.map(&:length).reduce :+
    end

    def to_s
      if flights.any?
        flights.map(&:to_s).join ' | '
      else
        [@src.to_s, @dst.to_s].join ' -> '
      end
    end
  end
end
