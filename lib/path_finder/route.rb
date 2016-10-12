module PathFinder
  class Route
    attr_accessor :start, :end, :flights, :current, :past_cities

    def initialize(input)
      @start, @end = input
      @current = @start
      @past_cities = []
      @flights = []
      @complete = false
    end

    def add_flight(flight)
      @flights << flight
      @current = flight.end
      @past_cities << @current
      @complete = true if @current.name == @end.name
    end

    # def self.copy(route)
    #   new_route = Route.new([route.start, route.end])
    #   route.flights.each { |f| new_route.add_flight f }
    #   new_route
    # end

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
        [@start.to_s, @end.to_s].join ' -> '
      end
    end
  end
end
