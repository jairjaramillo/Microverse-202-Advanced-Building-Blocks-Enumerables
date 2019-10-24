# frozen_string_literal: true

# Microverse-202-Advanced-Building-Blocks-Enumerables
# By Jair Jaramillo

# module enum
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

  def bubble_sort_by(arra)
    (arra.size - 1).times do |x|
      arra[x], arra[x + 1] = arra[x + 1], arra[x] if yield(arra[x], arra[x + 1]).positive?
    end
    (arra.size - 1).times do |x|
      next unless (arra[x].length - arra[x + 1].length).positive?

      bubble_sort_by(arra) do |_left, _right|
        yield(arra[x], arra[x + 1])
      end
    end
    arra
  end

  def my_each
    return to_enum unless block_given?

    counter = 0
    while counter < to_a.length
      yield to_a[counter]
      counter += 1
    end
  end

  def my_each_with_index(counter = 0)
    while counter < to_a.length
      yield to_a[counter], counter
      counter += 1
    end
  end

  def my_select
    result = []
    i = 0
    while i < to_a.length
      result << to_a[i] if yield to_a[i]
      i += 1
    end
    result
  end

  def my_all?(pattern = false)
    if block_given?
      my_each { |item| return false if !(yield item) == false }
    elsif !pattern == true
      my_each { |item| return false if (pattern == item) == false }
    else
      my_each { |item| return false unless item == false }
    end
    true
  end

  def my_any?(pattern = false)
    if block_given?
      my_each { |item| return true if yield item }
    elsif !pattern == true
      my_each { |item| return true if pattern == item }
    else
      my_each { |item| return true unless item }
    end
    false
  end

  def my_none?(pattern = false)
    if block_given?
      my_each { |item| return false if yield item }
    elsif !pattern == true
      my_each { |item| return false if pattern == item }
    else
      my_each { |item| return false unless item }
    end
    true
  end

  def my_count(pattern = false)
    count = 0
    if block_given?
      my_each { |item| count += 1 if yield item }
    elsif !pattern == true
      my_each { |item| count += 1 if pattern == item }
    else
      my_each { |item| count += 1 unless item }
    end
    count
  end

  def my_map(proc = nil)
    result = []
    to_a.my_each do |item|
      if proc
        result.push(proc.call(item))
      elsif block_given?
        result.push(yield item)
      end
    end
    result
  end

  def my_inject(init = nil, &block)
    return to_a[1..-1].my_inject(first, &block) if init.nil?

    addition = init
    my_each { |item| addition = yield addition, item } if block_given?
    addition
  end
end

def multiply_els(arra)
  arra.my_inject { |accum, item| accum * item }
end
