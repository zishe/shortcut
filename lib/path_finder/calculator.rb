module PathFinder
  class Calculator
    attr_accessor :cities, :flights, :routes, :graph

    def initialize
      @cities = []
      @flights = []
      @routes = []
      @graph = Graph.new
    end

    def add_city(input)
      city = City.new(input.split)
      @cities << city
      @graph << city
    end

    def add_flight(input)
      flight = Flight.new(find_cities input)
      @flights << flight
      @graph.edges << flight
    end

    def add_route(input)
      @routes << Route.new(find_cities input)
    end

    def find_cities(input)
      input.split.map do |city_name|
        @cities.find { |city| city.name == city_name }
      end
    end

    def find_route_graph
      @routes.each { |route|
        result = @graph.dijkstra(route.src, route.dst)
        puts result.nil? ? 'no route exists' : "#{result[:distance].round} km  ( #{result[:path].join(' -> ')} )"
      }
    end

    def build_routes
      @routes.each { |path| build_route path }
    end

    def build_route(path)
      curr_step = 0

      routes = [path]
      next_routes = []
      shortcut = nil

      # пока есть незавершенные маршруты И количество шагов маньше количства городов - 1
      while routes.any? && curr_step < cities.size - 1
        routes.each do |route|
          # найти все маршруты начинающиеся в последнем городе строящегося маршрута
          match_flights = @flights.select { |flight| flight.src == route.current }

          # puts "#{match_flights.size} match flights"
          match_flights.each do |match_flight|
            # исключаем зацикленный машрут
            next if match_flight.dst == route.src

            # не проходим джажды один и тот же город дважды
            next if route.past_cities.include? match_flight.dst

            new_route = Route.new([route.src, route.dst])
            route.flights.each { |f| new_route.add_flight f }
            new_route.add_flight match_flight

            if new_route.completed?
              # принимаем результат если  нет ни одного пути  или  новый путь короче существующего
              shortcut = new_route if shortcut.nil? || new_route.length < shortcut.length
              # puts "new route #{new_route} #{new_route.length}"
            else
              next_routes << new_route unless shortcut && shortcut.length < new_route.length
            end
          end
        end

        routes = next_routes
        next_routes = []

        curr_step += 1
      end

      puts shortcut.nil? ? 'no route exists' : "#{shortcut.length.round} km (#{shortcut})"
      shortcut
    end
  end
end
