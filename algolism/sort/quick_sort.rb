class Array
  def quick_sort
    return self if size <= 1

    base = self.pop
    smaller, bigger = partition { |v| v < base }
    smaller.quick_sort + [base] + bigger.quick_sort
  end
end

p [8, 4, 3, 7, 6, 5, 2, 1].quick_sort == [1, 2, 3, 4, 5, 6, 7, 8]
