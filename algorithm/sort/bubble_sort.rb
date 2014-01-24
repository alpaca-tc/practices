class Array
  def bubble_sort
    temp = self.dup

    new_array = []
    new_array.push(temp.bubbling) until temp.empty?
    new_array
  end

  def bubbling
    (self.size - 1).times do |i|
      self[i], self[i + 1] = self[i + 1], self[i] if self[i] < self[i + 1]
    end

    delete_at(-1)
  end
end

p [8, 4, 3, 7, 6, 5, 2, 1].bubble_sort == [1, 2, 3, 4, 5, 6, 7, 8]
