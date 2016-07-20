def selection_sort(array)
  array = array.dup
  sorted_array = []

  while array.length > 0
    index = find_smallest_index(array)
    sorted_array << array.delete_at(index)
  end

  sorted_array
end

def find_smallest_index(array)
  smallest = array[0]
  smallest_index = 0

  array.drop(1).each_with_index do |value, index|
    next unless value < smallest
    smallest = value
    smallest_index = index + 1
  end

  smallest_index
end

if $0 == __FILE__
  require 'minitest/autorun'

  describe '#find_smallest_index' do
    it 'returns index of smallest element' do
      find_smallest_index([1,2,3]).must_equal 0
      find_smallest_index([3,2,1]).must_equal 2
    end
  end

  describe '#selection_sort' do
    it 'returns sorted array' do
      selection_sort([5,2,3,4,1]).must_equal [1,2,3,4,5]
      selection_sort([3,5,2,1,4]).must_equal [1,2,3,4,5]
    end

    it 'does not mutate original array' do
      array = [5,2,3,4,1]
      selection_sort(array)

      array.must_equal [5,2,3,4,1]
    end
  end
end
