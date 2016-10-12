require './lib/path_finder'

input = File.readlines('data/test2').map(&:strip).reject(&:empty?)

n, m, q = input.shift.split.map(&:to_i)

calc = PathFinder::Calculator.new

n.times { calc.add_city(input.shift) }
m.times { calc.add_flight(input.shift) }
q.times { calc.add_route(input.shift) }

calc.build_routes
