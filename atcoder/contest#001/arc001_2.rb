from, to = gets.strip.split(/\s/).map { |v| v.to_i }

diff = (from - to).abs

count = 0
until diff == 0
  diff = [(diff - 10).abs, (diff - 5).abs, (diff - 1).abs].min
  count += 1
end

puts count
