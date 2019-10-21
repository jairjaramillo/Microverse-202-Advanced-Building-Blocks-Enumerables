# frozen_string_literal: true

def bubble_sort(array)
  (array.size - 1).times do |x|
    array[x], array[x + 1] = array[x + 1], array[x] if array[x] > array[x + 1]
  end
  (array.size - 1).times do |x|
    bubble_sort(array) if array[x] > array[x + 1]
  end
  # sort_check.call array
  array
end

test_array = [4, 3, 78, 2, 0, 2]
print bubble_sort(test_array)
puts

def bubble_sort_by(arra)
  (arra.size - 1).times do |x|
    arra[x], arra[x + 1] = arra[x + 1], arra[x] if yield(arra[x], arra[x + 1]).positive? # yield = left.length - right.length
  end
  (arra.size - 1).times do |x|
    next unless (arra[x].length - arra[x + 1].length).positive?

    bubble_sort_by(arra) do |_left, _right|
      yield(arra[x], arra[x + 1])
    end
  end
  arra
end

test = bubble_sort_by(%w[hello hey hi]) do |left, right|
  left.length - right.length
end

print test
