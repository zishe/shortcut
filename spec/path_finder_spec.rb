require './lib/path_finder'

describe PathFinder::Calculator do
  describe '.build_routes' do
    it '"returns proper data for test_data"' do
      input = File.readlines('test_data').map(&:strip).reject(&:empty?)

      i = 1
      result = {}
      while input.any?
        case_start = input.shift
        next unless case_start =~ /\d+\s+/

        numbers = case_start.scan(/\d+/).map(&:to_i)
        next unless numbers.reduce(:+) > 0 && numbers.size == 3

        calc = PathFinder::Calculator.new
        n, m, q = numbers
        n.times { calc.add_city(input.shift) }
        m.times { calc.add_flight(input.shift) }
        q.times { calc.add_route(input.shift) }

        result[i] = calc.build_routes.map { |r| r && r.length && r.length.round }

        i += 1
      end

      expect(result).to eq(1 => [485, 231], 2 => [19654, nil, 12024], 3 => [8803, 15841, 13219])
    end
  end
end
