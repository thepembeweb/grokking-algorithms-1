def quicksort(array)
  return array if array.length < 2
  array = array.dup
  pivot = array.delete_at(rand(array.length))

  less, greater = array.each_with_object([[], []]) do |value, memo|
    memo[0] << value if value <= pivot
    memo[1] << value if value > pivot
  end

  return [*quicksort(less), pivot, *quicksort(greater)]
end

if $0 == __FILE__
  require 'minitest/autorun'

  describe '#quicksort' do
    it 'returns arrays of length < 2 unchanged' do
      quicksort([]).must_equal []
      quicksort([1]).must_equal [1]
    end

    it 'returns sorted array' do
      quicksort([2,1]).must_equal [1,2]

      array = (1..100).to_a
      quicksort(array.shuffle).must_equal array
    end

    it 'does not mutate original array' do
      array = [5,2,3,4,1]
      quicksort(array)

      array.must_equal [5,2,3,4,1]
    end
  end
end
