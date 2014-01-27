items = [
  { weight: 1, value: 5 },
  { weight: 1, value: 3 },
  { weight: 5, value: 9 },
  { weight: 2, value: 8 },
  { weight: 2, value: 4 },
  { weight: 3, value: 7 },
]

def knapsack(items, i, capacity)
  unless @memo[i][capacity]
    @memo[i][capacity] = if i.zero? || capacity.zero?
      0
    elsif items[i - 1][:weight] > capacity
      knapsack(items, i - 1, capacity)
    else
      [
        knapsack(items, i - 1, capacity),
        items[i - 1][:value] + knapsack(items, i - 1, capacity - items[i-1][:weight])
      ].max
    end
  end

  @memo[i][capacity]
end

@memo = Hash.new { |h,k| h[k] = {} }
puts knapsack(items, items.length, 10)
