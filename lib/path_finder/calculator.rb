module PathFinder
  class Calculator
    attr_accessor :cities, :flights, :routes

    def initialize
      @cities = []
      @flights = []
      @routes = []
    end

    def add_city(input)
      @cities << City.new(input.split)
    end

    def add_flight(input)
      @flights << Flight.new(find_cities input)
    end

    def add_route(input)
      @routes << Route.new(find_cities input)
    end

    def find_cities(input)
      input.split.map do |city_name|
        @cities.find { |city| city.name == city_name }
      end
    end

    def build_routes
      @routes.each { |path|
        route = build_route path
        puts route.nil? ? 'no route exists' : "#{route.length.round} km"
      }
    end

    def build_route(path)
      routes = [path]
      next_routes = []
      shortcut = nil

      # while there are unfinished flights
      while routes.any?
        routes.each do |route|
          # search all flights started from current city
          match_flights = @flights.select { |flight| flight.src == route.current }
          match_flights.each do |match_flight|
            # exclude looped route
            next if match_flight.dst == route.src

            # don't pass twice the same city
            next if route.past_cities.include? match_flight.dst

            # copy route to a new one and add new flight
            new_route = Route.new([route.src, route.dst])
            route.flights.each { |f| new_route.add_flight f }
            new_route.add_flight match_flight

            if new_route.completed?
              # accept the result if there is no path or a new path is shorter than the existing
              shortcut = new_route if shortcut.nil? || new_route.length < shortcut.length
              # puts "new route #{new_route} #{new_route.length}"
            else
              # continue to build the route unless it's already longer then existing route
              next_routes << new_route unless shortcut && shortcut.length < new_route.length
            end
          end
        end

        routes = next_routes
        next_routes = []
      end

      shortcut
    end
  end
end
