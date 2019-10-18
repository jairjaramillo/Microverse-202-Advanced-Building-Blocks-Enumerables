# frozen_string_literal: true

# module
module Enumerable
  def bubble_sort(array)
    (array.size - 1).times do |x|
      array[x], array[x + 1] = array[x + 1], array[x] if array[x] > array[x + 1]
    end
    (array.size - 1).times do |x|
      bubble_sort(array) if array[x] > array[x + 1]
    end
    array
  end

  test_array = [4, 3, 78, 2, 0, 2]
  print bubble_sort(test_array)
  puts

  def bubble_sort_by(arra)
    (arra.size - 1).times do |x|
      if yield(arra[x], arra[x + 1]).positive?
        arra[x], arra[x + 1] = arra[x + 1], arra[x]
      end
    end
    (arra.size - 1).times do |x|
      if arra[x].length - arra[x + 1].length > 0
        bubble_sort_by(arra) do |left, right|
          yield(arra[x], arra[x + 1])
        end
      end
    end
    arra
  end

  def my_each
    i = 0
    while i < self.to_a.length
      yield self.to_a[i]
      i += 1
    end
  end

  def my_all? (pattern = false)
    if !pattern == true
      self.my_each{|item| return false if (pattern === item) == false}
    else
      self.my_each{|item| return false if !!item == false}
    end
    true
  end
end
