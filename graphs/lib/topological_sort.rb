require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  num_in_edges = []
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      num_in_edges << vertex
    end
  end

  until num_in_edges.empty? do
    current = num_in_edges.shift
    current.out_edges.reverse_each do |edge|
      edge.destroy!
    end

    sorted << current

    vertices.delete current
    vertices.each do |vertex|
      if vertex.in_edges.empty?
        unless num_in_edges.include? vertex
          num_in_edges << vertex
        end
      end
    end
  end

  vertices.length.zero? ? sorted : []

end
