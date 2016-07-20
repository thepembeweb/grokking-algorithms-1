def binary_search(array, item, low = 0, high = nil)
  high ||= array.length - 1
  mid = (low + high) / 2
  guess = array[mid]

  return mid if guess == item
  return nil if low == high
  return binary_search(array, item, high, high) if low == mid
  return binary_search(array, item, low, mid) if guess > item
  return binary_search(array, item, mid, high) if guess < item
end

if $0 == __FILE__
  require 'minitest/autorun'

  describe '#binary_search' do
    before do
      @array = (1..100).to_a
    end

    it 'returns index of passed in element' do
      binary_search(@array, 1).must_equal 0
      binary_search(@array, 50).must_equal 49
      binary_search(@array, 100).must_equal 99
    end

    it 'returns nil if the passed in element is not found' do
      binary_search(@array, 101).must_equal nil
      binary_search(@array, -1).must_equal nil
    end
  end
end
