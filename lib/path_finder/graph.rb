module PathFinder
  class Graph < Array
    attr_reader :edges

    def initialize
      @edges = []
    end

    def neighbors(vertex)
      @edges.map { |edge| edge.src == vertex ? edge.dst : nil }.compact.uniq
    end

    def length_between(src, dst)
      edge = @edges.find { |edge| edge.src == src && edge.dst == dst }
      edge && edge.length
    end

    def dijkstra(src, dst = nil)
      distances = {}
      previouses = {}
      self.each do |vertex|
        distances[vertex] = nil # Infinity
        previouses[vertex] = nil
      end

      distances[src] = 0
      vertices = self.clone
      until vertices.empty?
        nearest_vertex = vertices.reduce do |a, b|
          # p "#{a} #{b} #{distances[a]} #{distances[b]}"
          next b unless distances[a]
          next a unless distances[b]
          next a if distances[a] < distances[b]
          b
        end
        break unless distances[nearest_vertex] # Infinity

        if dst && nearest_vertex == dst
          return { path: get_path(previouses, src, dst), distance: distances[dst] }
        end

        neighbors = vertices.neighbors(nearest_vertex)
        neighbors.each do |vertex|
          alt = distances[nearest_vertex] + vertices.length_between(nearest_vertex, vertex)
          if distances[vertex].nil? || alt < distances[vertex]
            distances[vertex] = alt
            previouses[vertex] = nearest_vertex
          end
        end
        vertices.delete nearest_vertex
      end
      if dst
        nil
      else
        paths = {}
        distances.each { |k, _| paths[k] = get_path(previouses, src, k) }
        { paths: paths, distances: distances }
      end
    end

    private
    def get_path(previouses, src, dst)
      path = get_path_recursively(previouses, src, dst)
      path.is_a?(Array) ? path.reverse : path
    end

    # Unroll through previouses array until we get to source
    def get_path_recursively(previouses, src, dst)
      return src if src == dst
      raise ArgumentException, "No path from #{src} to #{dst}" if previouses[dst].nil?
      [dst, get_path_recursively(previouses, src, previouses[dst])].flatten
    end
  end
end
