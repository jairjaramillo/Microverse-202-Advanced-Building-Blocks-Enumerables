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

  def my_each_with_index
    return to_enum unless block_given?

    counter = 0
    while counter < to_a.length
      yield to_a[counter], counter
      counter += 1
    end
  end

  def my_select
    return to_enum unless block_given?

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
      my_each { |x| return false unless yield(x) }
    elsif pattern.class == Class
      my_each { |x| return false unless x.class == pattern }
    elsif pattern.class == Regexp
      my_each { |x| return false unless x =~ pattern }
    elsif pattern.nil?
      my_each { |x| return false unless x }
    else
      my_each { |x| return false unless x == pattern }
    end
    true
  end

  def my_any?(pattern = false)
    if block_given?
      my_each { |x| return true if yield(x) }
    elsif pattern.class == Class
      my_each { |x| return true if x.class == pattern }
    elsif pattern.class == Regexp
      my_each { |x| return true if x =~ pattern }
    elsif pattern.nil?
      my_each { |x| return true if x }
    else
      my_each { |x| return true if x == pattern }
    end
    false
  end

  def my_none?(pattern = false)
    if block_given?
      my_each { |x| return false if yield(x) }
    elsif pattern.class == Class
      my_each { |x| return false if x.class == pattern }
    elsif pattern.class == Regexp
      my_each { |x| return false if x =~ pattern }
    elsif pattern.nil?
      my_each { |x| return false if x }
    else
      my_each { |x| return false if x == pattern }
    end
    true
  end

  def my_count(things = false)
    counter = 0
    if block_given?
      my_each { |x| counter += 1 if yield(x) == true }
    elsif things.nil?
      my_each { counter += 1 }
    else
      my_each { |x| counter += 1 if x == things }
    end
    counter
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

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

  def my_inject(*args)
    arr = to_a.dup
    if args[0].nil?
      operand = arr.shift
    elsif args[1].nil? && !block_given?
      symbol = args[0]
      operand = arr.shift
    elsif args[1].nil? && block_given?
      operand = args[0]
    else
      operand = args[0]
      symbol = args[1]
    end

    arr[0..-1].my_each do |i|
      operand = if symbol
                  operand.send(symbol, i)
                else
                  yield(operand, i)
                end
    end
    operand
  end
end

def multiply_els(arra)
  arra.my_inject { |accum, item| accum * item }
end
