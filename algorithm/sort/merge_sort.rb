class Array
  def merge_sort
    temp = self.dup
    return self if self.size <= 1

    half = (self.size / 2).ceil
    a, b = split(half).map { |v| v.merge_sort }
    a.merge(b)
  end

  def split(index)
    [slice(0...index), slice(index..-1)]
  end

  def merge(other)
    new_array = []
    until self.empty? && other.empty?
      new_array << case
      when other.empty?
        self.shift
      when self.empty?
        other.shift
      when self.first < other.first
        self.shift
      else
        other.shift
      end
    end

    new_array
  end
end

p [8, 4, 3, 7, 6, 5, 2, 1].merge_sort == [1, 2, 3, 4, 5, 6, 7, 8]
