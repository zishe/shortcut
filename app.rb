require './lib/path_finder'

input = File.readlines('test_data').map(&:strip).reject(&:empty?)

i = 1
while input.any?
  case_start = input.shift
  next unless case_start =~ /\d+\s+/

  numbers = case_start.scan(/\d+/).map(&:to_i)
  next unless numbers.reduce(:+) > 0 && numbers.size == 3

  puts "Case ##{i}"

  calc = PathFinder::App.new
  n, m, q = numbers
  n.times { calc.add_city(input.shift) }
  m.times { calc.add_flight(input.shift) }
  q.times { calc.add_route(input.shift) }

  calc.build_routes.each do |route|
    puts route.nil? ? 'no route exists' : "#{route.length.round} km"
  end

  i += 1
  puts ''
end
