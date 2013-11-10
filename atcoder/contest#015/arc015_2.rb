LENGTH = gets.strip.to_i

body = []

LENGTH.times do
  body << gets.strip.split(/\s/).map { |i| i.to_f }
  # body = [
  #   [32.2, 25.3],
  #   [36.4, 26.4],
  #   [24.1, 18.0],
  #   [26.0, 24.9],
  # ]
end

res = {
  over_35: 0, # 35 <= max
  over_30: 0, # 30 <= max < 35
  over_25: 0, # 25 <= max < 30
  under_25: 0, # 25 <= min
  frost_day: 0, # min < 0, 0 <= max
  ice_day: 0, # max < 0
}

body.each do |(max, min)|
  res[:over_35] += 1 if 35 <= max
  res[:over_30] += 1 if 30 <= max && max < 35
  res[:over_25] += 1 if 25 <= max && max < 30
  res[:under_25] += 1 if 25 <= min
  res[:frost_day] += 1 if min < 0 && 0 <= max
  res[:ice_day] += 1 if max < 0
end
puts [res[:over_35], res[:over_30], res[:over_25], res[:under_25], res[:frost_day], res[:ice_day]].join(' ')
