require 'set'

def breadth_first_search(nodes, value, searched: Set.new)
  to_search = []

  [*nodes].each do |node|
    return true if node.value.eql?(value)
    searched.add node
    to_search.concat(node.neighbors - searched.to_a)
  end

  return false if to_search.empty?
  breadth_first_search(to_search, value, searched: searched)
end

class Node
  attr_reader :value

  def initialize(value)
    @value = value
    @neighbors = Set.new
  end

  def connect(nodes)
    [*nodes].each do |node|
      raise 'Cannot connect to self' if node.eql?(self)
      @neighbors.add node
    end
  end

  def neighbors
    @neighbors.to_a
  end
end

if $0 == __FILE__
  require 'minitest/autorun'

  describe '#breadth_first_search' do
    before do
      graph = {
        a: [:g, :e, :f],
        b: [:d, :g, :e, :a, :f],
        c: [:e],
        d: [:a, :c],
        e: [:g, :b],
        f: [:g, :a],
        g: [:a]
      }

      nodes = Hash[graph.keys.map { |key| [key, Node.new(key)] }]

      nodes.each do |key, node|
        neighbors = graph.fetch(key).map { |key| nodes.fetch(key) }
        node.connect neighbors
      end

      @starting_node = nodes.values.slice(rand(nodes.values.length))
    end

    it 'returns false if the value is not present in the graph' do
      breadth_first_search(Node.new(:a), :z).must_equal false
      breadth_first_search(@starting_node, :z).must_equal false
    end

    it 'returns true if the value is present in the graph' do
      breadth_first_search(Node.new(:d), :d).must_equal true
      breadth_first_search(@starting_node, :d).must_equal true
    end
  end
end
