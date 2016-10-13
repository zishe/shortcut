require './lib/path_finder'

describe PathFinder::Calculator do
  describe '.build_routes' do
    it '"returns proper data for test1"' do
      exec_from_file 'test1', [485, 231]
    end

    it '"returns proper data for test2"' do
      exec_from_file 'test2', [19654, nil, 12024]
    end

    it '"returns proper data for test3"' do
      exec_from_file 'test3', [8803, 15844]
    end
  end

  def exec_from_file(name, data)
    input = File.readlines("data/#{name}").map(&:strip).reject(&:empty?)

    n, m, q = input.shift.split.map(&:to_i)

    calc = PathFinder::Calculator.new

    n.times { calc.add_city(input.shift) }
    m.times { calc.add_flight(input.shift) }
    q.times { calc.add_route(input.shift) }

    routes = calc.build_routes
    expect(routes.map { |r| r && r.length && r.length.round }).to eq data
  end
end
