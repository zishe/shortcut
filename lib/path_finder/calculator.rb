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
          match_flights = @flights.select { |flight| flight.start == route.current }

          # puts "#{match_flights.size} match flights"
          match_flights.each do |match_flight|
            # исключаем зацикленный машрут
            next if match_flight.end == route.start

            # не проходим джажды один и тот же город дважды
            next if route.past_cities.include? match_flight.end

            new_route = Route.new([route.start, route.end])
            route.flights.each { |f| new_route.add_flight f }
            new_route.add_flight match_flight

            if new_route.completed?
              # принимаем результат если  нет ни одного пути  или  новый путь короче существующего
              shortcut = new_route if shortcut.nil? || new_route.length < shortcut.length
              puts "new route #{new_route} #{new_route.length}"
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
