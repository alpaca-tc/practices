class Array
  def select_sort
    temp = self.dup
    new_object = []
    new_object.push(temp.delete_min) until temp.empty?
    new_object
  end

  private

  def delete_min
    min_index = find_index { |v| v == self.min }
    delete_at(min_index)
  end
end

p [8, 4, 3, 7, 6, 5, 2, 1].select_sort == [1, 2, 3, 4, 5, 6, 7, 8]
