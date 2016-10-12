module PathFinder
  class City
    attr_accessor :name, :lat, :lon

    def initialize(input)
      @name = input.shift
      @lat, @lon = input.map(&:to_f)
    end

    def to_s
      @name
    end
  end
end
