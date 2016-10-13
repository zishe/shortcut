require 'benchmark'

require './lib/path_finder'

input = File.readlines('data/test3').map(&:strip).reject(&:empty?)

n, m, q = input.shift.split.map(&:to_i)

calc = PathFinder::Calculator.new

n.times { calc.add_city(input.shift) }
m.times { calc.add_flight(input.shift) }
q.times { calc.add_route(input.shift) }


puts Benchmark.measure {
  calc.build_routes
}.real

puts Benchmark.measure {
  calc.find_route_graph
}.real
